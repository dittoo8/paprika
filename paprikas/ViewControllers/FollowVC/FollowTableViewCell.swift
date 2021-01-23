//
//  FollowTableViewCell.swift
//  paprikas
//
//  Created by 박소현 on 2021/01/23.
//

import UIKit

class FollowTableViewCell: UITableViewCell {

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
