//
//  RegistrationViewModel.swift
//  Z
//
//  Created by Lasitha Weligampola on 2024-01-27.
//

import Foundation

class RegistrationViewModel: ObservableObject{
    @Published var email = ""
    @Published var fullname = ""
    @Published var username = ""
    @Published var password = ""
    
    
    @MainActor
    func createUser() async throws {
       try await AuthService.shared.register(
            withEmail: email,
            password: password,
            fullname: fullname,
            username: username)
    }
}
