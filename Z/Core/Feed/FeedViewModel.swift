//
//  FeadViewModel.swift
//  Z
//
//  Created by Lasitha Weligampola on 2024-01-28.
//

import Foundation

@MainActor
class FeedViewModel: ObservableObject {
    @Published var threads = [Thread]()
    @Published var showAddComment = false
    var selectedThread: Thread? {
        didSet { self.showAddComment = selectedThread != nil }
    }
    
    init() {
        Task { try await fetchThreads() }
    }
    
    func fetchThreads() async throws {
        self.threads  = try await ThreadService.fetchThreads()
        try await fetchUserDataForFeeds()
    }
    
    private func fetchUserDataForFeeds() async throws {
        for i in 0 ..< threads.count {
            let thread = threads[i]
            let ownerUid = thread.ownerUid
            
            let threadUser = try await UserService.fetchUser(withUid: ownerUid)
            
            threads[i].user = threadUser
        }
    }
}
