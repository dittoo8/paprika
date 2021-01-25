//
//  FarmTableViewCell.swift
//  paprikas
//
//  Created by 박소현 on 2021/01/25.
//

import UIKit
import Kingfisher
class FarmTableViewCell: UITableViewCell {

    @IBOutlet weak var badgeImgView: UIImageView!
    @IBOutlet weak var userProfileImgView: UIImageView! {
        didSet {
            self.userProfileImgView.layer.cornerRadius = self.userProfileImgView.frame.height/2
            self.userProfileImgView.clipsToBounds = true
        }
    }
    @IBOutlet weak var userNicknameLabel: UILabel!

    func configureCell(userId: Int, nickname: String, userphoto: URL) {
        tag = userId
        userProfileImgView.kf.setImage(with: userphoto)
        userNicknameLabel.text = nickname
    }
}
