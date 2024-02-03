//
//  ThreadCreationViewModel.swift
//  Z
//
//  Created by Lasitha Weligampola on 2024-01-28.
//

import Firebase
import Combine

class ThreadCreationViewModel: ObservableObject {
    @Published var user:User?
    
    private var cancellable: AnyCancellable?
    
    
    init(){
        setupSubscribers()
    }
    
    private func setupSubscribers(){
        cancellable =  UserService.shared.$currentUser.sink { [weak self] user in
            self?.user = user
        }
    }
    
    func startThread(_ caption: String) async throws {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        let thread = Thread(ownerUid: uid, caption: caption, timestamp: Timestamp(), likes: 0, replies: 0)
        try await ThreadService.uploadThread(thread)
    }
    
}
