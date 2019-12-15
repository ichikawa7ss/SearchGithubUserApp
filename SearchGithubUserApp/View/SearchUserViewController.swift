//
//  SearchUserViewController.swift
//  SearchGithubUserApp
//
//  Created by 市川星磨 on 2019/12/16.
//  Copyright © 2019 市川 星磨. All rights reserved.
//

import UIKit

class SearchUserViewController: UIViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    public var test: String?

    func inject(test: String) {
        self.test = test
        print("inject text: \(String(describing: self.test))")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setup()
    }
    
    private func setup() {
        tableView.delegate = self
        tableView.dataSource = self

        tableView.estimatedRowHeight = 80
        tableView.rowHeight = UITableView.automaticDimension
        tableView.register(UINib(nibName: "UserTableViewCell", bundle: nil), forCellReuseIdentifier: "UserTableViewCell")
    }
    
}

extension SearchUserViewController: UITableViewDelegate {
    
}

extension SearchUserViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UserTableViewCell") as! UserTableViewCell
        return cell
    }
}

extension SearchUserViewController: UISearchBarDelegate {
    
}
