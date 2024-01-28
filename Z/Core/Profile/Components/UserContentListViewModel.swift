//
//  UserContentListViewModel.swift
//  Z
//
//  Created by Lasitha Weligampola on 2024-01-28.
//

import Foundation

class UserContentListViewModel: ObservableObject{
    @Published var threads = [Thread]()
    
    let user: User
    
    init(user: User) {
        self.user = user
        Task { try await fetchThreadsForUser() }
    }
    
    @MainActor
    func fetchThreadsForUser()async throws{
        var threads = try await ThreadService.fetchThreadsForUser(uid: user.id)
        
        for i in 0 ..< threads.count {
            threads[i].user = self.user
        }
        
        self.threads = threads
    }
}
