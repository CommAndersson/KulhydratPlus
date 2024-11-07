//
//  LoginView.swift
//  Kulhydrat+
//
//  Created by Sigurd Andersson on 23/10/2024.
//

import SwiftUI
import GoogleSignIn
import FBSDKLoginKit
import FBSDKCoreKit

struct LoginView: View {
    @EnvironmentObject private var authService: AuthService
    @Environment(\.presentationMode) var presentationMode
    @State private var email = ""
    @State private var password = ""
    @State private var isShowingRegister = false
    @State private var errorMessage = ""
    @State private var isLoading = false

    var body: some View {
        NavigationView {
            ZStack {
                Color.white.edgesIgnoringSafeArea(.all)

                VStack(spacing: 25) {
                    Text("Kulhydrat+")
                        .font(.system(size: 60, weight: .bold))
                        .foregroundColor(Color("GrønTekst"))
                        .padding(.top, 60)

                    VStack(alignment: .leading, spacing: 15) {
                        Text("Log ind")
                            .font(.system(size: 30, weight: .bold))
                            .foregroundColor(.black)
                            .padding(.bottom, 10)

                        VStack(alignment: .leading, spacing: 8) {
                            TextField("Email", text: $email)
                                .textFieldStyle(CustomTextFieldStyle())
                                .autocapitalization(.none)
                                .keyboardType(.emailAddress)

                            SecureField("Password", text: $password)
                                .textFieldStyle(CustomTextFieldStyle())
                        }

                        if !errorMessage.isEmpty {
                            Text(errorMessage)
                                .foregroundColor(.red)
                                .font(.system(size: 14))
                        }
                    }
                    .padding(.horizontal, 30)

                    // Email Login Button
                    Button(action: login) {
                        ZStack {
                            Rectangle()
                                .frame(width: 300, height: 50)
                                .foregroundColor(Color("GrønEmneBaggrund"))
                                .cornerRadius(10)

                            if isLoading {
                                ProgressView()
                                    .progressViewStyle(CircularProgressViewStyle(tint: .black))
                            } else {
                                Text("Log ind")
                                    .foregroundColor(.black)
                                    .font(.system(size: 20))
                            }
                        }
                    }
                    .disabled(isLoading)

                    // Divider
                    HStack {
                        Rectangle()
                            .frame(height: 1)
                            .foregroundColor(.gray.opacity(0.3))

                        Text("eller")
                            .foregroundColor(.gray)
                            .font(.system(size: 14))

                        Rectangle()
                            .frame(height: 1)
                            .foregroundColor(.gray.opacity(0.3))
                    }
                    .frame(width: 300)
                    .padding(.vertical, 10)

                    // Google Sign In Button
                    Button(action: signInWithGoogle) {
                        ZStack {
                            Rectangle()
                                .frame(width: 300, height: 50)
                                .foregroundColor(.white)
                                .cornerRadius(10)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(Color.gray.opacity(0.3), lineWidth: 1)
                                )

                            HStack {
                                Image(systemName: "g.circle.fill")
                                    .resizable()
                                    .frame(width: 20, height: 20)
                                    .foregroundColor(.blue)
                                Text("Fortsæt med Google")
                                    .foregroundColor(.black)
                                    .font(.system(size: 18))
                            }
                        }
                    }
                    
                    
                    // Facebook Sign In Button
                    Button(action: signInWithFacebook) {  // Changed from inline Task to method
                        ZStack {
                            Rectangle()
                                .frame(width: 300, height: 50)
                                .foregroundColor(Color(red: 66/255, green: 103/255, blue: 178/255))
                                .cornerRadius(10)

                            HStack {
                                Image(systemName: "f.square.fill")
                                    .resizable()
                                    .frame(width: 20, height: 20)
                                    .foregroundColor(.white)
                                Text("Fortsæt med Facebook")
                                    .foregroundColor(.white)
                                    .font(.system(size: 18))
                            }
                        }
                    }
                    .disabled(isLoading)  // Add this to prevent multiple taps while loading
               

                    // Register Button (Updated to match styling)
                    Button(action: { isShowingRegister = true }) {
                        ZStack {
                            Rectangle()
                                .frame(width: 300, height: 50)
                                .foregroundColor(Color("GrønEmneBaggrund").opacity(0.7))
                                .cornerRadius(10)

                            Text("Opret ny bruger")
                                .foregroundColor(.black)
                                .font(.system(size: 20))
                        }
                    }
                    .padding(.top, 10)

                    // Continue Without User Button
                    Button(action: continueWithoutUser) {
                        ZStack {
                            Rectangle()
                                .frame(width: 300, height: 50)
                                .foregroundColor(Color("GrønEmneBaggrund").opacity(0.7))
                                .cornerRadius(10)

                            Text("Fortsæt uden bruger")
                                .foregroundColor(.black)
                                .font(.system(size: 20))
                        }
                    }
                    .padding(.top, 10)
                }
            }
            .sheet(isPresented: $isShowingRegister) {
                RegisterView()
            }
        }
    }

    /// Login with email and password
    private func login() {
        Task {
            do {
                isLoading = true
                try await authService.login(email: email, password: password)
                await MainActor.run {
                    isLoading = false
                    presentationMode.wrappedValue.dismiss()
                }
            } catch {
                await MainActor.run {
                    isLoading = false
                    errorMessage = "Ugyldig email eller password"
                }
            }
        }
    }

    /// Sign in with Google
    private func signInWithGoogle() {
        Task {
            do {
                isLoading = true
                try await authService.signInWithGoogle()
                await MainActor.run {
                    isLoading = false
                    presentationMode.wrappedValue.dismiss()
                }
            } catch {
                await MainActor.run {
                    isLoading = false
                    errorMessage = "Google login fejlede. Prøv igen."
                }
            }
        }
    }
    
    
    /// Sign in with Facebook
    private func signInWithFacebook() {
        Task {
            do {
                isLoading = true
                try await authService.signInWithFacebook()
                await MainActor.run {
                    isLoading = false
                    presentationMode.wrappedValue.dismiss()
                }
            } catch {
                await MainActor.run {
                    isLoading = false
                    errorMessage = "Facebook login fejlede. Prøv igen."
                }
            }
        }
    }
    

    /// Continue without user authentication
    private func continueWithoutUser() {
        authService.continueAnonymously()
    }
}
