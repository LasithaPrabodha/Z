//
//  ExploreViewModel.swift
//  Z
//
//  Created by Lasitha Weligampola on 2024-01-27.
//

import Foundation

class ExploreViewModel: ObservableObject {
    @Published var users = [User]()
    
    init(){
        Task { try await fetchUsers() }
    }
    
    @MainActor
    private func fetchUsers() async throws {
        self.users = try await UserService.fetchUsers()
    }
}
