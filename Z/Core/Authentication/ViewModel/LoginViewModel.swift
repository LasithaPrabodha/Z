//
//  LoginViewModel.swift
//  Z
//
//  Created by Lasitha Weligampola on 2024-01-27.
//

import Foundation

class LoginViewModel: ObservableObject{
    @Published var email = ""
    @Published var password = ""
    
    @MainActor
    func loginUser() async throws {
       try await AuthService.shared.login(withEmail: email, password: password)
    }
}
