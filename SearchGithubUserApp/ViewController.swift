//
//  ViewController.swift
//  SearchGithubUserApp
//
//  Created by 市川星磨 on 2019/12/15.
//  Copyright © 2019 市川 星磨. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let apiClient = GithubAPIClient()
        let request = SearchUserRequest(keyword: "ichikawa")
        print(request.buildUrl())

        apiClient.send(request: request) { (result) in
            print("完了ハンドラ")
        }
    }


}

