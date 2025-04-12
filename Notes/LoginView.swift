//
//  LoginView.swift
//  Notes
//
//  Created by Brandon Robb on 4/12/25.
//

import SwiftUI

struct LoginView: View {
    @StateObject private var authViewModel = AuthViewModel()
    @State private var email = ""
    @State private var password = ""
    @State private var isLoginMode = true
    @State private var errorMessage = ""
    @State private var showingError = false
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                Text(isLoginMode ? "Welcome Back" : "Create Account")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.bottom, 30)
                
                TextField("Email", text: $email)
                    .autocapitalization(.none)
                    .disableAutocorrection(true)
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(8)
                    .padding(.horizontal)
                
                SecureField("Password", text: $password)
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(8)
                    .padding(.horizontal)
                
                Button(action: {
                    if isLoginMode {
                        // Sign in
                        authViewModel.signIn(email: email, password: password) { success, error in
                            if !success, let error = error {
                                errorMessage = error
                                showingError = true
                            }
                        }
                    } else {
                        // Sign up
                        authViewModel.signUp(email: email, password: password) { success, error in
                            if !success, let error = error {
                                errorMessage = error
                                showingError = true
                            }
                        }
                    }
                }) {
                    Text(isLoginMode ? "Sign In" : "Create Account")
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(8)
                        .padding(.horizontal)
                }
                
                Button(action: {
                    isLoginMode.toggle()
                }) {
                    Text(isLoginMode ? "Don't have an account? Sign Up" : "Already have an account? Sign In")
                        .foregroundColor(.blue)
                }
                .padding()
            }
            .alert(isPresented: $showingError) {
                Alert(title: Text("Error"), message: Text(errorMessage), dismissButton: .default(Text("OK")))
            }
            .padding()
            .navigationTitle(isLoginMode ? "Sign In" : "Sign Up")
        }
        .fullScreenCover(isPresented: $authViewModel.signedIn) {
            ContentView()
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
