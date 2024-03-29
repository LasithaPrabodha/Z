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
                .collection("likes")
                .addDocument(data: [
                    "uid": uid,
                    "threadId": threadId
                ])
        }
    }
    
    static func removeLike(threadId: String) async throws {
        let value: Double = -1
        try await Firestore.firestore()
            .collection("threads")
            .document(threadId)
            .updateData(["likes": FieldValue.increment(value)])
        
        if let uid = UserService.shared.currentUser?.id {
            let snapshot = try await Firestore.firestore()
                .collection("likes")
                .whereField("uid", isEqualTo: uid)
                .whereField("threadId", isEqualTo: threadId)
                .getDocuments()
            
            let likes = snapshot.documents.compactMap({ try? $0.data(as: Like.self)})
            
            try await Firestore.firestore()
                .collection("likes")
                .document(likes[0].id)
                .delete()
        }
    }
    static func getUserLikes(uid: String) async throws -> [Like] {
        let snapshot = try await Firestore.firestore()
            .collection("likes")
            .whereField("uid", isEqualTo: uid)
            .getDocuments()
        
        return snapshot.documents.compactMap({ try? $0.data(as: Like.self)})
    }
    
    
    static func checkLikedByUser(threadId: String, uid: String) async throws -> Bool {
        let docRef = Firestore.firestore()
            .collection("likes")
            .whereField("uid", isEqualTo: uid)
            .whereField("threadId", isEqualTo: threadId)
        
        return try await docRef.getDocuments().count != 0
    }
    
    
}
