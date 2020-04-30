//
//  User.swift
//  GitHub_Followers
//
//  Created by Maxim Granchenko on 30.04.2020.
//  Copyright © 2020 Maxim Granchenko. All rights reserved.
//

import Foundation

struct User: Codable {
    var login: String
    var avatarUrl: String
    var name: String?
    var location: String?
    var bio: String?
    var htmlUrl: String
    var company: String?
    var createdAt: String
    var publicRepos: Int
    var publicGists: Int
    var followers: Int
    var following: Int
}
