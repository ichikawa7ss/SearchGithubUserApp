//
//  SearchUserRequest.swift
//  SearchGithubUserApp
//
//  Created by 市川星磨 on 2019/12/15.
//  Copyright © 2019 市川 星磨. All rights reserved.
//

import Foundation

struct SearchUserRequest : GithubRequest {    
    typealias Response = SearchUserResponse
    var keyword: String
}
