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
}
