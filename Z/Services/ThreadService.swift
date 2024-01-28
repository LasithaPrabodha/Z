//
//  THreadService.swift
//  Z
//
//  Created by Lasitha Weligampola on 2024-01-28.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift

struct ThreadService {
    static func uploadThread(_ thread: Thread) async throws {
        guard let threadData = try? Firestore.Encoder().encode(thread) else { return }
        try await Firestore.firestore().collection("threads").addDocument(data: threadData)
    }
    
    static func fetchThreads() async throws -> [Thread] {
        let snapshot = try await Firestore
            .firestore()
            .collection("threads")
            .order(by: "timestamp", descending: true)
            .getDocuments()
        
        return snapshot.documents.compactMap({ try? $0.data(as: Thread.self)})
    }
    
    static func fetchThreadsForUser(uid: String) async throws -> [Thread] {
        let snapshot = try await Firestore
            .firestore()
            .collection("threads")
            .order(by: "timestamp", descending: true)
            .whereField("ownerUid", isEqualTo: uid)
            .getDocuments()
        
        
        return snapshot.documents.compactMap({ try? $0.data(as: Thread.self)})
        
    }
    
    static func addLike(threadId: String) async throws {
        let value: Double = 1
        try await Firestore.firestore()
            .collection("threads")
            .document(threadId)
            .updateData(["likes": FieldValue.increment(value)])
        
        if let uid = UserService.shared.currentUser?.id {
            try await Firestore.firestore()
                .collection("users")
                .document(uid)
                .collection("likes")
                .document(threadId)
                .setData(["like": 1])
        }
    }
    
    static func getUserLikes(uid: String) async throws -> [Like] {
        let snapshot = try await Firestore.firestore()
            .collection("users")
            .document(uid)
            .collection("likes")
            .getDocuments()
        
        return snapshot.documents.compactMap({ try? $0.data(as: Like.self)})
    }
    
    
    static func checkLikedByUser(threadId: String, uid: String) async throws -> Bool {
        let docRef = Firestore.firestore()
            .collection("users")
            .document(uid)
            .collection("likes")
            .document(threadId)
        
        return try await docRef.getDocument().exists
    }
    
    static func removeLike(threadId: String) async throws {
        let value: Double = -1
        try await Firestore.firestore()
            .collection("threads")
            .document(threadId)
            .updateData(["likes": FieldValue.increment(value)])
        
        if let uid = UserService.shared.currentUser?.id {
            try await Firestore.firestore()
                .collection("users")
                .document(uid)
                .collection("likes")
                .document(threadId)
                .delete()
        }
    }
}
