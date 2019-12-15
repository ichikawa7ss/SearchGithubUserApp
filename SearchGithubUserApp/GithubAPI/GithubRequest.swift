//
//  GithubRequest.swift
//  SearchGithubUserApp
//
//  Created by 市川星磨 on 2019/12/15.
//  Copyright © 2019 市川 星磨. All rights reserved.
//

import Foundation

internal protocol GithubRequest {
    associatedtype Response : Codable
    
    var baseURL : URL { get }
    var queryItems: [URLQueryItem] { get }
    var keyword : String { get set }
}

extension GithubRequest {
    var baseURL : URL {
        return URL(string: "https://api.github.com/search/users")!
    }
    
    var queryItems : [URLQueryItem] {
        // keywordでlogin内を部分一致検索
        let query = "\(keyword)+in:login"
        return [URLQueryItem(name: "q", value: query)]
    }
    
    func buildUrl() -> URL {
        let url = baseURL
        var components = URLComponents(url: url, resolvingAgainstBaseURL: true)!
        components.queryItems = queryItems
        return components.url!
    }
    
    // レスポンスで取得したデータからレスポンス型で取り出す
    // デコードでエラーが発生した場合はthrowする
    func response (from data: Data) throws -> Response {
        let decoder = JSONDecoder()
        // アプリで扱えるようにデコードして、結果を返す
        return try decoder.decode(Response.self, from: data)
    }
}
