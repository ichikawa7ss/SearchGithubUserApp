//
//  User.swift
//  SearchGithubUserApp
//
//  Created by 市川星磨 on 2019/12/15.
//  Copyright © 2019 市川 星磨. All rights reserved.
//

import Foundation

struct User: Codable {
    let id: Int
    let avatarUrlStr: String
    var avatarUrl: URL {
        return URL(string: avatarUrlStr)!
    }
    
    let htmlUrlStr: String
    var htmlUrl: URL {
        return URL(string: htmlUrlStr)!
    }
    
    let type: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case avatarUrlStr = "avatar_url"
        case htmlUrlStr = "html_url"
        case type
    }
}

struct SearchUserResponse: Codable {
    let total: Int
    var users: [User] = []
    
    enum CodingKeys: String, CodingKey {
        case total = "total_count"
        case users = "items"
    }
}
