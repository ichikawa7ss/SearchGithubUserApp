//
//  Error.swift
//  SearchGithubUserApp
//
//  Created by 市川星磨 on 2019/12/16.
//  Copyright © 2019 市川 星磨. All rights reserved.
//

import Foundation

enum SearchError: Error {
    case connectionError
    case responseParseError
}
