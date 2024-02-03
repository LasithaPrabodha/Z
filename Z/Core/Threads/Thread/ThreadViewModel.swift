//
//  ThreadViewModel.swift
//  Z
//
//  Created by Lasitha Weligampola on 2024-02-03.
//

import Foundation

@MainActor
class ThreadViewModel: ObservableObject {
    @Published var replies = [Thread]()
    
    init(thread: Thread){
        Task { try await fetchReplies(thread.id) }
    }
    
    func fetchReplies(_ threadId: String) async throws {
        var _replies  = try await ReplyService.fetchReplies(for: threadId)
        
        for i in 0 ..< _replies.count {
            let reply = _replies[i]
            let ownerUid = reply.ownerUid
            
            let threadUser = try await UserService.fetchUser(withUid: ownerUid)
            
            _replies[i].user = threadUser
            self.replies.append(_replies[i])
        }
        
    }
}
