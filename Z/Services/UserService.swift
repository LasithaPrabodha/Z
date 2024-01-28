//
//  UserService.swift
//  Z
//
//  Created by Lasitha Weligampola on 2024-01-27.
//

import Foundation
import FirebaseFirestoreSwift
import Firebase


class UserService{
    @Published var currentUser: User?
    
    static let shared = UserService()
    
    init(){
        Task { try await fetchCurrentUser() }
    }
    
    
    static func fetchUsers() async throws -> [User]{
        guard let currentUid = Auth.auth().currentUser?.uid else { return [] }
        let snapshot = try await Firestore.firestore().collection("users").getDocuments()
        let users = snapshot.documents.compactMap({ try? $0.data(as: User.self )})
        
        return users.filter({ $0.id != currentUid })
    }
    
    @MainActor
    func fetchCurrentUser() async throws {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        let snapshot = try await Firestore.firestore().collection("users").document(uid).getDocument()
        let user = try snapshot.data(as: User.self)
        
        self.currentUser = user
    }
    
    func reset(){
        self.currentUser = nil
    }
    
    @MainActor
    func updateUserProfileImage(withImageUrl imageUrl: String) async throws {
        guard let currentUd = Auth.auth().currentUser?.uid else { return }
        try await Firestore.firestore().collection("users").document(currentUd).updateData([
            "profileImageUrl": imageUrl
        ])
        
        self.currentUser?.profileImageUrl = imageUrl
    }
}
