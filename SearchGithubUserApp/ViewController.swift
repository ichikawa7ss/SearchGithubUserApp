//
//  ViewController.swift
//  SearchGithubUserApp
//
//  Created by 市川星磨 on 2019/12/15.
//  Copyright © 2019 市川 星磨. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    public var test: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
            
        if self.test != nil {
            print("viewDidLoad text: \(String(describing: self.test))")
        }

        // Do any additional setup after loading the view.
        let apiClient = GithubAPIClient()
        let request = SearchUserRequest(keyword: "ichikawa")
        print(request.buildUrl())

        apiClient.send(request: request) { (result) in
            print("完了ハンドラ")
        }
    }
    
    func inject(test: String) {
        self.test = test
        print("inject text: \(String(describing: self.test))")
    }
}

