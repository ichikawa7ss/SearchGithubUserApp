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
    private var users: [User]?

    func inject(test: String) {
        self.test = test
        print("inject text: \(String(describing: self.test))")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let apiClient = GithubAPIClient()
        let request = SearchUserRequest(keyword: "ichikawa")
        print(request.buildUrl())

        apiClient.send(request: request) { (result) in
            switch result {
            case .success(let response):
                self.users = response.users
            case .failure( _): break
                // TODO: Error Handling
            }
            self.tableView.reloadData()
        }
        
        setup()
    }
    
    private func setup() {
        searchBar.delegate = self
        
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
        if let users = self.users {
            return users.count
        } else {
            return 10
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UserTableViewCell") as! UserTableViewCell
        if let user = self.users?[indexPath.row] {
            cell.configure(user: user)
        }
        return cell
    }
}

extension SearchUserViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        print("tap")
        self.tableView.reloadData()
    }
}
