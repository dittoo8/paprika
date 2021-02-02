//
//  SearchResultTableViewCell.swift
//  paprikas
//
//  Created by user on 2021/02/02.
//

import UIKit

class SearchResultTableViewCell: UITableViewCell {

    @IBOutlet weak var userProfileImgView: UIImageView! {
        didSet {
            self.userProfileImgView.layer.cornerRadius = self.userProfileImgView.frame.height/2
            self.userProfileImgView.clipsToBounds = true
        }
    }
    @IBOutlet weak var userNicknameLabel: UILabel!
    func configureWith(userID: Int, userNickname: String, userPhoto: URL) {
        userProfileImgView.kf.setImage(with: userPhoto)
        userNicknameLabel.text = userNickname
        tag = userID
    }

}
