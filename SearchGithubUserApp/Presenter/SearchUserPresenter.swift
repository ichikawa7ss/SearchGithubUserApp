//
//  SearchUserPresenter.swift
//  SearchGithubUserApp
//
//  Created by 市川星磨 on 2019/12/16.
//  Copyright © 2019 市川 星磨. All rights reserved.
//

import Foundation

/// ユーザ検索プレゼンターの入力に関するプロトコル
protocol SearchUserPresenterInput {
    var numberOfUsers: Int { get }
    func user(forItem index: Int) -> User?
    func didSelectRow(at index: Int)
    func didTapSearchButton(text: String?) throws
}

/// プレゼンターからの処理を委譲するプロトコル
protocol SearchUserPresenterOutput: AnyObject {
    func updateUsers(_ users: [User])
    func transitionToDetailWebView(url: URL)
}

class SearchUserPresenter: SearchUserPresenterInput {
    
    // viewは処理を委譲する
    private weak var view: SearchUserPresenterOutput!
    
    init(view: SearchUserPresenterOutput) {
        self.view = view
    }

    // 画像はプレゼンタークラス内からのみ変更可能
    private(set) var users: [User] = []
        
    var numberOfUsers: Int {
        return users.count
    }
    
    func user(forItem index: Int) -> User? {
        return users[index]
    }
    
    func didSelectRow(at index: Int) {
        let url = users[index].htmlUrl
        view.transitionToDetailWebView(url: url)
    }
    
    func didTapSearchButton(text: String?) throws {
        let apiClient = GithubAPIClient()
        let request = SearchUserRequest(keyword: "ichikawa")
        print(request.buildUrl())

        apiClient.send(request: request) { (result) in
            switch result {
            case .success(let response):
                self.users = response.users
                self.view.updateUsers(self.users)
            case .failure( _): break
                // TODO: Error Handling
            }
        }
    }
}
