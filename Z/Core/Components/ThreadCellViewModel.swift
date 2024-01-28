//
//  ThreadCellViewModel.swift
//  Z
//
//  Created by Lasitha Weligampola on 2024-01-28.
//

import Foundation

@MainActor
class ThreadCellViewModel: ObservableObject {
    @Published var likes: Int = 0
    @Published var liked = false
    
    init(thread: Thread) {
        self.likes = thread.likes
        
        Task { try await checkLikedByTheUser(threadId: thread.id) }
    }
    
    func checkLikedByTheUser(threadId: String) async throws {
        if let uid = AuthService.shared.userSession?.uid{
            self.liked = try await ThreadService.checkLikedByUser(threadId: threadId, uid: uid)
        }
    }
    
    func incrementLikes(threadId: String) async throws {
        try await ThreadService.addLike(threadId: threadId)
        self.likes += 1
        self.liked.toggle()
    }
    
    func removeLike(threadId: String) async throws {
        try await ThreadService.removeLike(threadId: threadId)
        self.likes -= 1
        self.liked.toggle()
    }
}
