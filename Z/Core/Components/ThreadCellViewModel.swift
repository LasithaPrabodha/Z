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
    @Published var replies: Int = 0
    @Published var liked = false
    @Published var isYourProfile = false
    
    init(thread: Thread) {
        self.likes = thread.likes
        self.replies = thread.replies
        self.isYourProfile = UserService.shared.currentUser?.id == thread.user?.id
        
        Task { try await checkLikedByTheUser(threadId: thread.id) }
    }
    
    func checkLikedByTheUser(threadId: String) async throws {
        if let uid = AuthService.shared.userSession?.uid{
            self.liked = try await ThreadService.checkLikedByUser(threadId: threadId, uid: uid)
        }
    }
    
    func incrementLikes(threadId: String, _ isReply: Bool) async throws {
        if isReply{
            try await ReplyService.addLike(threadId: threadId)
        }else{
            try await ThreadService.addLike(threadId: threadId)
        }
        self.likes += 1
        self.liked.toggle()
    }
    
    func removeLike(threadId: String, _ isReply: Bool) async throws {
        if isReply{
            try await ReplyService.removeLike(threadId: threadId)
        }else{
            try await ThreadService.removeLike(threadId: threadId)
        }
        
        self.likes -= 1
        self.liked.toggle()
    }
}
