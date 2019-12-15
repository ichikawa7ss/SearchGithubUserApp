//
//  GithubAPIClient.swift
//  SearchGithubUserApp
//
//  Created by 市川星磨 on 2019/12/16.
//  Copyright © 2019 市川 星磨. All rights reserved.
//

import Foundation
import Alamofire

class GithubAPIClient {
    
    func send<Request: GithubRequest>(
        request: Request,
        completion: @escaping (Result<Request.Response, SearchError>) -> ()) {
        
        let url = request.buildUrl()
        
        // alamofireによる通信処理
        Alamofire.request(url).validate(statusCode: 200..<400).responseJSON { response in
            // Resultの結果で場合分け
            switch response.result {
            case .success(_):
                do {
                    let response = try request.response(from: response.data!)
                    // 呼び出し元の処理を実行
                    completion(Result(value: response))
                } catch _ {
                    // 不正なレスポンス
                    completion(Result(error: .responseParseError))
                }
            case .failure(_):
                completion(Result(error: .connectionError))
            }
        }
    }
}
