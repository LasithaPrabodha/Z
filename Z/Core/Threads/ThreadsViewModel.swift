//
//  FeadViewModel.swift
//  Z
//
//  Created by Lasitha Weligampola on 2024-01-28.
//

import Foundation

@MainActor
class ThreadsViewModel: ObservableObject {
    @Published var threads = [Thread]()
    
    init() {
        Task { try await fetchThreads() }
    }
    
    func fetchThreads() async throws {
        var _threads  = try await ThreadService.fetchThreads()
        self.threads = []
        
        for i in 0 ..< _threads.count {
            let thread = _threads[i]
            let ownerUid = thread.ownerUid
            
            let threadUser = try await UserService.fetchUser(withUid: ownerUid)
            
            _threads[i].user = threadUser
            self.threads.append(_threads[i])
        }
        
    }
}
