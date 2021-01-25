//
//  FarmTableViewCell.swift
//  paprikas
//
//  Created by 박소현 on 2021/01/25.
//

import UIKit

class FarmTableViewCell: UITableViewCell {

    @IBOutlet weak var badgeImgView: UIImageView!
    @IBOutlet weak var userProfileImgView: UIImageView! {
        didSet {
            self.userProfileImgView.layer.cornerRadius = self.userProfileImgView.frame.height/2
            self.userProfileImgView.clipsToBounds = true
        }
    }
    @IBOutlet weak var userNicknameLabel: UILabel!

    func configureCell(userId: Int, userphoto: URL, rank: Int) {

    }
}
