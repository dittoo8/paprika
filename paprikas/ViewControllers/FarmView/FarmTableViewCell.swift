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

    func configureCell(userId: Int, nickname: String, userphoto: URL, rank: Int) {
        tag = userId
        userProfileImgView.kf.setImage(with: userphoto)
        userNicknameLabel.text = nickname
        switch rank {
        case 0:
            badgeImgView.image = UIImage(named: "medal_1st.png")
        case 1:
            badgeImgView.image = UIImage(named: "medal_2nd.png")
        case 2:
            badgeImgView.image = UIImage(named: "medal_3rd.png")
        default:
            badgeImgView.image = nil
        }
    }
}
