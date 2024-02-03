//
//  ReplyService.swift
//  Z
//
//  Created by Lasitha Weligampola on 2024-02-03.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift

struct ReplyService {
    static func addReply(_ reply: Thread, isParentReply: Bool) async throws {
        guard let replyData = try? Firestore.Encoder().encode(reply) else {return}
        
        try await Firestore.firestore()
            .collection("replies")
            .addDocument(data: replyData)
        
        let value: Double = 1
        try await Firestore.firestore()
            .collection(isParentReply ? "replies": "threads" )
            .document(reply.mainThreadId!)
            .updateData(["replies": FieldValue.increment(value)])
    }
    
    static func fetchReplies(for threadId: String) async throws -> [Thread] {
        let snapshot = try await Firestore
            .firestore()
            .collection("replies")
            .order(by: "timestamp", descending: true)
            .whereField("mainThreadId", isEqualTo: threadId)
            .getDocuments()
        
        return snapshot.documents.compactMap({ try? $0.data(as: Thread.self)})
    }
    
    static func addLike(threadId: String) async throws {
        let value: Double = 1
        try await Firestore.firestore()
            .collection("replies")
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
            .collection("replies")
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
    
}
