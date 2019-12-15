//
//  SearchUserModel.swift
//  SearchGithubUserApp
//
//  Created by 市川星磨 on 2019/12/16.
//  Copyright © 2019 市川 星磨. All rights reserved.
//

import Foundation

/// 画像情報検索モデルへの入力に関するプロトコル
protocol SearchUserModelInput {
    func fetchUsers<Request: GithubRequest>
        (request: Request,completion: @escaping (Result<Request.Response,Error>) -> ())
}

/// 画像情報検索用モデル
final class SearchUserModel : SearchUserModelInput {
    
    /// ユーザ情報の取得を行う
    /// - Parameter request: APIリクエスト
    /// - Parameter completion: 完了ハンドラ
    func fetchUsers<Request>(request: Request, completion: @escaping (Result<Request.Response,Error>) -> ()) where Request : GithubRequest {
        
        // APIクライアント
        let apiClient = GithubAPIClient()
        
        // リクエスト送信処理
        apiClient.send(request: request) { result in
            switch result {
            case let .success(response):
                completion(.success(response))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
