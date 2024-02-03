//
//  Like.swift
//  Z
//
//  Created by Lasitha Weligampola on 2024-01-28.
//

import Foundation
import FirebaseFirestoreSwift

struct Like: Identifiable, Codable {
    @DocumentID var likeId: String?
    let uid: String
    let threadId: String
    var id: String{
        return likeId ?? NSUUID().uuidString
    }
}
