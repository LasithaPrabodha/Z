//
//  AuthService.swift
//  Z
//
//  Created by Lasitha Weligampola on 2024-01-27.
//

import Foundation
import Firebase

class AuthService {
    @Published var userSession: FirebaseAuth.User?
    
    static let shared = AuthService()
    
    init() {
        self.userSession = Auth.auth().currentUser
    }
    
    @MainActor
    func login(withEmail email:String, password: String) async throws {
        do {
            let result = try await Auth.auth().signIn(withEmail: email, password: password)
            self.userSession = result.user
            print("DEBUG: User logged in \(result.user.uid)")
        } catch {
            print("DEBUG: Failed to login user \(error.localizedDescription)")
        }
    }
    
    @MainActor
    func register(withEmail email:String, password: String, fullname: String, username: String) async throws {
        do {
            let result = try await Auth.auth().createUser(withEmail: email, password: password)
            self.userSession = result.user
            print("DEBUG: Created user \(result.user.uid)")
        } catch {
            print("DEBUG: Failed to create user \(error.localizedDescription)")
        }
    }
    
    func signOut(){
        try? Auth.auth().signOut() // signout in firebase
        self.userSession = nil // clear local session
    }
}
