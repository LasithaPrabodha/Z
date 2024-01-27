//
//  ProfileThreadFilter.swift
//  Z
//
//  Created by Lasitha Weligampola on 2024-01-27.
//

import Foundation

enum ProfileThreadFilter: Int, CaseIterable, Identifiable {
    case threads
    case replies
//    case likes
    
    var titles: String {
        switch self {
        case .threads: return "Threads"
        case .replies: return "Replies"
        }
    }
    
    var id: Int { return self.rawValue }
}
