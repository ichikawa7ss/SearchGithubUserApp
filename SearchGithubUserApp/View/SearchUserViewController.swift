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
    
    private var users: [User]?
    
    private var presenter: SearchUserPresenterInput!

    func inject(presenter: SearchUserPresenterInput) {
        self.presenter = presenter
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.didSelectRow(at: indexPath.row)
    }
}

extension SearchUserViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.numberOfUsers
//        if let users = self.users {
//            return users.count
//        } else {
//            return 10
//        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UserTableViewCell") as! UserTableViewCell
        if let user = presenter.user(forItem: indexPath.row) {
            cell.configure(user: user)
        }
        return cell
    }
}

extension SearchUserViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        do {
            try presenter.didTapSearchButton(text: searchBar.text)
        } catch let error {
            // TODO エラーハンドリング
            print(error)
        }
    }
}

extension SearchUserViewController: SearchUserPresenterOutput {
    func updateUsers(_ users: [User]) {
        self.tableView.reloadData()
    }
    
    func transitionToDetailWebView(user: User) {
        let storyboard = self.storyboard!
        let detailWebVC = storyboard.instantiateViewController(withIdentifier: "detailWebVC") as! DetailWebViewController
        detailWebVC.title = user.login
        detailWebVC.url = user.htmlUrl
        navigationController?.pushViewController(detailWebVC, animated: true)
    }
}
