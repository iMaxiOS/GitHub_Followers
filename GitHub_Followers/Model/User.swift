//
//  User.swift
//  GitHub_Followers
//
//  Created by Maxim Granchenko on 30.04.2020.
//  Copyright © 2020 Maxim Granchenko. All rights reserved.
//

import Foundation

struct User: Codable {
    let login: String
    let avatarUrl: String
    var name: String?
    var location: String?
    var bio: String?
    var company: String?
    let htmlUrl: String
    let createdAt: String
    let publicRepos: Int
    let publicGists: Int
    let followers: Int
    let following: Int
}
