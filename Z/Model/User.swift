//
//  User.swift
//  Z
//
//  Created by Lasitha Weligampola on 2024-01-27.
//

import Foundation

struct User: Identifiable, Codable{
    let id:String
    let fullname:String
    let email:String
    let username:String
    var profileImageUrl:String? = ""
    var bio:String? = ""
}
