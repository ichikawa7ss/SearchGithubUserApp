//
//  UserTableViewCell.swift
//  SearchGithubUserApp
//
//  Created by 市川星磨 on 2019/12/16.
//  Copyright © 2019 市川 星磨. All rights reserved.
//

import UIKit

class UserTableViewCell: UITableViewCell {

    @IBOutlet weak var accountImageView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var accontTypeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        accountImageView.image = UIImage(systemName: "photo")
        userNameLabel.text = "ichikawa7ss"
        accontTypeLabel.text = "User"
    }
    
    func configure(user: User) {
        // TODO 画像・ラベルの設定
    }

}
