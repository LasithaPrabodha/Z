//
//  PreviewProvider.swift
//  Z
//
//  Created by Lasitha Weligampola on 2024-01-27.
//

import SwiftUI
import Firebase

extension PreviewProvider {
    static var dev: DeveloperPreview {
        return DeveloperPreview.shared
    }
}

class DeveloperPreview {
    static let shared = DeveloperPreview()
    
    let user = User(id: NSUUID().uuidString, fullname: "Lasitha Prabodha", email: "lasitha@gmail.com", username: "lu6_fer")
    
    let thread = Thread(ownerUid: "123", caption: "Test thread", timestamp: Timestamp(), likes: 12, user: User(id: NSUUID().uuidString, fullname: "Lasitha Prabodha", email: "lasitha@gmail.com", username: "lu6_fer"))
}
