//
//  Follower.swift
//  GitHubFollowers
//
//  Created by Roberto Evangelista on 04/01/20.
//  Copyright © 2020 Roberto Evangelista. All rights reserved.
//

import Foundation

struct Follower: Codable, Hashable {
    var login: String
    var avatarUrl: String
}
