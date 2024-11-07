//
//  RegisterView.swift
//  Kulhydrat+
//
//  Created by Sigurd Andersson on 23/10/2024.
//

import SwiftUI

struct RegisterView: View {
    @EnvironmentObject private var authService: AuthService
    @Environment(\.presentationMode) var presentationMode
    @State private var email = ""
    @State private var password = ""
    @State private var name = ""
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
                        Text("Opret bruger")
                            .font(.system(size: 30, weight: .bold))
                            .foregroundColor(.black)
                            .padding(.bottom, 10)
                        
                        VStack(alignment: .leading, spacing: 8) {
                            TextField("Navn", text: $name)
                                .textFieldStyle(CustomTextFieldStyle())
                            
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
                    
                    // Register Button
                    Button(action: register) {
                        ZStack {
                            Rectangle()
                                .frame(width: 300, height: 50)
                                .foregroundColor(Color("GrønEmneBaggrund"))
                                .cornerRadius(10)
                            
                            if isLoading {
                                ProgressView()
                                    .progressViewStyle(CircularProgressViewStyle(tint: .black))
                            } else {
                                Text("Opret bruger")
                                    .foregroundColor(.black)
                                    .font(.system(size: 20))
                            }
                        }
                    }
                    .disabled(isLoading)
                }
            }
            .navigationBarItems(leading: Button("Annuller") {
                presentationMode.wrappedValue.dismiss()
            })
        }
    }
    
    /// Register a new user
    private func register() {
        Task {
            do {
                await MainActor.run { isLoading = true }
                try await authService.register(email: email, password: password, name: name)
                await MainActor.run {
                    isLoading = false
                    presentationMode.wrappedValue.dismiss()
                }
            } catch {
                await MainActor.run {
                    errorMessage = "Der opstod en fejl. Prøv igen."
                    isLoading = false
                }
            }
        }
    }
}
