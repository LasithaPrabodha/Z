//
//  CommentViewModel.swift
//  Z
//
//  Created by Lasitha Weligampola on 2024-01-28.
//

import Firebase

class CommentViewModel: ObservableObject{
    @Published var reply = ""
    let thread: Thread
    let replier: User
    
    init(thread: Thread){
        self.thread = thread
        self.replier = UserService.shared.currentUser!
    }
    
    func postReply(isParentReply: Bool) async throws {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        let thread = Thread(ownerUid: uid, caption: reply, timestamp: Timestamp(), likes: 0, replies: 0, mainThreadId: self.thread.id)
        try await ReplyService.addReply(thread, isParentReply: isParentReply)
    }
}
