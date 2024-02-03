//
//  Thread.swift
//  Z
//
//  Created by Lasitha Weligampola on 2024-01-28.
//

import Firebase
import FirebaseFirestoreSwift

struct Thread: Identifiable, Codable, Hashable {
    @DocumentID var threadId: String?
    let ownerUid: String
    let caption: String
    let timestamp: Timestamp
    var likes: Int
    let replies: Int
    var user: User?
    var mainThreadId: String?
    var likedByCurrentUser: Bool? = nil
    
    var id: String{
        return threadId ?? NSUUID().uuidString
    }
}
