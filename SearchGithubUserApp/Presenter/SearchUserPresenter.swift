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
    func transitionToDetailWebView(user: User)
}

class SearchUserPresenter: SearchUserPresenterInput {
    
    // viewは処理を委譲する
    private weak var view: SearchUserPresenterOutput!
    private var model: SearchUserModelInput
    
    init(view: SearchUserPresenterOutput, model: SearchUserModelInput) {
        self.view = view
        self.model = model
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
        view.transitionToDetailWebView(user: users[index])
    }
    
    func didTapSearchButton(text: String?) throws {
        let request = SearchUserRequest(keyword: text!)

        // モデルに画像取得処理を依頼
        model.fetchUsers(request: request, completion: { result in
            switch result {
            case .success(let response):
                self.users = response.users
                DispatchQueue.main.async {
                    self.view.updateUsers(self.users)
                }
            case .failure( _): break
                // TODO: Error Handling
            }
        })
    }
}
