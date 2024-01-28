//
//  Thread.swift
//  Z
//
//  Created by Lasitha Weligampola on 2024-01-28.
//

import Firebase
import FirebaseFirestoreSwift

struct Thread: Identifiable, Codable {
    @DocumentID var threadId: String?
    let ownerUid: String
    let caption: String
    let timestamp: Timestamp
    var likes: Int
    var user: User?
    
    var id: String{
        return threadId ?? NSUUID().uuidString
    }
}
