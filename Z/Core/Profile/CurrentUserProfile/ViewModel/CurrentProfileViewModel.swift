//
//  CurrentProfileViewModel.swift
//  Z
//
//  Created by Lasitha Weligampola on 2024-01-27.
//

import Foundation
import Combine

class CurrentProfileViewModel: ObservableObject {
    @Published var currentUser:User?
    private var cancellable: AnyCancellable?

    
    init(){
        setupSubscribers()
    }
    
    private func setupSubscribers(){
        cancellable =  UserService.shared.$currentUser.sink { [weak self] user in
            self?.currentUser = user
        }
    }
}
