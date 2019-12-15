//
//  UserTableViewCell.swift
//  SearchGithubUserApp
//
//  Created by 市川星磨 on 2019/12/16.
//  Copyright © 2019 市川 星磨. All rights reserved.
//

import UIKit
import AlamofireImage

class UserTableViewCell: UITableViewCell {

    @IBOutlet weak var accountImageView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var accontTypeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configure(user: User) {
        // TODO 画像・ラベルの設定
        let placeholderImage = UIImage(systemName: "photo")
        self.accountImageView.af_setImage(withURL: user.avatarUrl, placeholderImage: placeholderImage)
        self.userNameLabel.text = user.login
        self.accontTypeLabel.text = user.type
    }

}
