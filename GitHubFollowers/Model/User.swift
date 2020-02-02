//
//  User.swift
//  GitHubFollowers
//
//  Created by Roberto Evangelista on 04/01/20.
//  Copyright © 2020 Roberto Evangelista. All rights reserved.
//

import Foundation

struct User: Codable {
    var avatarUrl: String
    var login: String
    var name: String?
    var location: String?
    var bio: String?
    var publicRepos: Int
    var publicGists: Int
    var htmlUrl: String
    var following: Int
    var followers: Int
    var createdAt: String
}
