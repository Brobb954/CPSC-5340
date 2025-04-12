//
//  AuthViewModel.swift
//  Notes
//
//  Created by Brandon Robb on 4/12/25.
//

import Foundation
import Firebase
import FirebaseAuth

class AuthViewModel: ObservableObject {
    @Published var signedIn = false
    
    init() {
        signedIn = Auth.auth().currentUser != nil
        
        Auth.auth().addStateDidChangeListener { [weak self] (auth, user) in
            self?.signedIn = user != nil
        }
    }
    
    func signIn(email: String, password: String, completion: @escaping (Bool, String?) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
            if let error = error {
                completion(false, error.localizedDescription)
            } else {
                self.signedIn = true
                completion(true, nil)
            }
        }
    }
    
    func signUp(email: String, password: String, completion: @escaping (Bool, String?) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password) { (result, error) in
            if let error = error {
                completion(false, error.localizedDescription)
            } else {
                self.signedIn = true
                completion(true, nil)
            }
        }
    }
    
    func signOut() {
        do {
            try Auth.auth().signOut()
            self.signedIn = false
        } catch {
            print("Error signing out: \(error)")
        }
    }
}
