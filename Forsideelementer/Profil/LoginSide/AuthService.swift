//
//  AuthService.swift
//  Kulhydrat+
//
//  Created by Sigurd Andersson on 23/10/2024.
//

import Foundation
import AuthenticationServices
import GoogleSignIn
import FBSDKLoginKit
import FBSDKCoreKit

class AuthService: ObservableObject {
    static let shared = AuthService()
    static let baseURL = "http://localhost:3000/api"
    
    @Published var isAuthenticated = false
    @Published var user: User?
    @Published var isLoggedIn: Bool = false
    @Published var isAnonymous = false
    @Published var isCheckingCredentials = true
    
    // MARK: - Data Models
    struct User: Codable {
        let id: Int
        let email: String
        let name: String?
        let authProvider: String?
        let socialId: String?
    }
    
    struct AuthResponse: Codable {
        let token: String
        let user: User
    }
    
    struct SocialAuthRequest: Codable {
        let token: String
        let provider: String
        let email: String?
        let name: String?
        let socialId: String
    }
    
    enum AuthError: Error {
        case invalidCredential
        case presentationError
        case cancelled
        case invalidResponse
        case serverError(statusCode: Int)
        case decodingError(String)
        case facebookError(String)
    }
    
    // MARK: - User Session Management
    private func saveUserSession(_ user: User, token: String) {
        UserDefaults.standard.set(token, forKey: "authToken")
        UserDefaults.standard.set(user.id, forKey: "userId")
        
        if let userData = try? JSONEncoder().encode(user) {
            UserDefaults.standard.set(userData, forKey: "userData")
        }
    }
    
    private func clearUserSession() {
        UserDefaults.standard.removeObject(forKey: "authToken")
        UserDefaults.standard.removeObject(forKey: "userId")
        UserDefaults.standard.removeObject(forKey: "userData")
        UserDefaults.standard.removeObject(forKey: "isAnonymousUser")
        
        // Clear CoreData
        PersistenceController.shared.clearAllData()
    }
    
    // MARK: - Authentication Methods
    func signInWithGoogle() async throws {
        print("Starting Google Sign-In process")
        
        guard let presentingViewController = (UIApplication.shared.connectedScenes.first as? UIWindowScene)?.windows.first?.rootViewController else {
            throw AuthError.presentationError
        }
        
        return try await withCheckedThrowingContinuation { continuation in
            GIDSignIn.sharedInstance.signIn(withPresenting: presentingViewController) { signInResult, error in
                if let error = error {
                    print("Google Sign-In error:", error)
                    continuation.resume(throwing: error)
                    return
                }
                
                guard let user = signInResult?.user,
                      let idToken = user.idToken?.tokenString else {
                    print("Failed to get user or idToken")
                    continuation.resume(throwing: AuthError.invalidCredential)
                    return
                }
                
                print("Successfully got Google user:", user.profile?.email ?? "No email")
                
                Task {
                    do {
                        let socialAuthRequest = SocialAuthRequest(
                            token: idToken,
                            provider: "google",
                            email: user.profile?.email,
                            name: user.profile?.name,
                            socialId: user.userID ?? ""
                        )
                        
                        try await self.sendSocialAuthRequest(socialAuthRequest)
                        continuation.resume()
                    } catch {
                        print("Social auth request failed:", error)
                        continuation.resume(throwing: error)
                    }
                }
            }
        }
    }
    
    func signInWithFacebook() async throws {
        // ... keep your existing Facebook sign-in code ...
    }
    
    private func sendSocialAuthRequest(_ request: SocialAuthRequest) async throws {
        let url = URL(string: "\(AuthService.baseURL)/auth/social-login")!
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let requestBody = try JSONEncoder().encode(request)
        urlRequest.httpBody = requestBody
        
        let (data, response) = try await URLSession.shared.data(for: urlRequest)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw AuthError.invalidResponse
        }
        
        guard (200...299).contains(httpResponse.statusCode) else {
            throw AuthError.serverError(statusCode: httpResponse.statusCode)
        }
        
        let authResponse = try JSONDecoder().decode(AuthResponse.self, from: data)
        
        await MainActor.run {
            self.user = authResponse.user
            self.isAuthenticated = true
            self.isLoggedIn = true
            self.saveUserSession(authResponse.user, token: authResponse.token)
        }
    }
    
    func logout() {
        Task { @MainActor in
            // Clear only local data
            SyncManager.shared.clearLocalData()
            
            // Clear user session
            self.user = nil
            self.isAuthenticated = false
            self.isLoggedIn = false
            self.isAnonymous = false
            
            // Clear stored credentials
            UserDefaults.standard.removeObject(forKey: "authToken")
            UserDefaults.standard.removeObject(forKey: "userId")
            UserDefaults.standard.removeObject(forKey: "isAnonymousUser")
            
            // Sign out of social providers if needed
            GIDSignIn.sharedInstance.signOut()
            LoginManager().logOut()
        }
    }
    
    func continueAnonymously() {
        Task { @MainActor in
            self.isAnonymous = true
            self.isAuthenticated = true
            self.user = nil
            UserDefaults.standard.set(true, forKey: "isAnonymousUser")
            print("Continuing without user authentication")
        }
    }
    
    func checkStoredCredentials() {
        if let token = UserDefaults.standard.string(forKey: "authToken") {
            if let userData = UserDefaults.standard.data(forKey: "userData"),
               let storedUser = try? JSONDecoder().decode(User.self, from: userData) {
                // Restore user from stored data while verifying token
                Task { @MainActor in
                    self.user = storedUser
                    self.isAuthenticated = true
                    self.isLoggedIn = true
                }
            }
            
            Task {
                do {
                    try await verifyToken(token)
                } catch {
                    await MainActor.run {
                        self.logout()
                    }
                }
                await MainActor.run {
                    self.isCheckingCredentials = false
                }
            }
        } else if UserDefaults.standard.bool(forKey: "isAnonymousUser") {
            Task { @MainActor in
                self.isAnonymous = true
                self.isAuthenticated = true
                self.user = nil
                self.isCheckingCredentials = false
            }
        } else {
            self.isCheckingCredentials = false
        }
    }
    
    private func verifyToken(_ token: String) async throws {
        let url = URL(string: "\(AuthService.baseURL)/auth/verify")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        let (data, _) = try await URLSession.shared.data(for: request)
        let response = try JSONDecoder().decode(AuthResponse.self, from: data)
        
        await MainActor.run {
            self.user = response.user
            self.isAuthenticated = true
            self.isLoggedIn = true
            self.saveUserSession(response.user, token: response.token)
        }
    }
    
    func login(email: String, password: String) async throws {
        print("Starting login process for email:", email)
        
        let url = URL(string: "\(AuthService.baseURL)/auth/login")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let body = ["email": email, "password": password]
        request.httpBody = try JSONEncoder().encode(body)
        
        let (data, _) = try await URLSession.shared.data(for: request)
        let response = try JSONDecoder().decode(AuthResponse.self, from: data)
        
        await MainActor.run {
            self.user = response.user
            self.isAuthenticated = true
            self.isLoggedIn = true
            self.saveUserSession(response.user, token: response.token)
        }
    }
    
    func register(email: String, password: String, name: String) async throws {
        let url = URL(string: "\(AuthService.baseURL)/auth/register")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let body = ["email": email, "password": password, "name": name]
        request.httpBody = try JSONEncoder().encode(body)
        
        let (data, _) = try await URLSession.shared.data(for: request)
        let response = try JSONDecoder().decode(AuthResponse.self, from: data)
        
        await MainActor.run {
            self.user = response.user
            self.isAuthenticated = true
            self.isLoggedIn = true
            self.saveUserSession(response.user, token: response.token)
        }
    }
    
    func getAuthToken() -> String? {
        return UserDefaults.standard.string(forKey: "authToken")
    }
    
    func getUserId() -> Int? {
        return UserDefaults.standard.object(forKey: "userId") as? Int
    }
}
