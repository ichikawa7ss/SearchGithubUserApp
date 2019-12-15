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
    func updateUsers(users: [User])
    func showErrorAlert(title: String)
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
                // 取得成功
                self.users = response.users
                DispatchQueue.main.async {
                    self.view.updateUsers(users: self.users)
                }
            case .failure(let error):

                    // 取得失敗
                // エラー内容により表示文を変更
                switch error {
                case .connectionError:
                    self.view.showErrorAlert(title: "通信環境の良い場所でお試しください")
                case .responseParseError:
                    self.view.showErrorAlert(title: "不明なエラー")
                }
            }
        })
    }
}
