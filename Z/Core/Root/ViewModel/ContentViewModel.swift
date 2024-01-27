//
//  ContentViewModel.swift
//  Z
//
//  Created by Lasitha Weligampola on 2024-01-27.
//

import Foundation
import Combine
import Firebase

class ContentViewModel: ObservableObject {
    @Published var userSession: FirebaseAuth.User?
    private var cancellable: AnyCancellable?
    
    init(){
        setupSubscribers()
    }
    
    private func setupSubscribers(){
        cancellable = AuthService.shared.$userSession.sink { [weak self] userSession in
            self?.userSession = userSession
        }
    }
}

