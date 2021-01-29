//
//  FoFCollectionViewCell.swift
//  paprikas
//
//  Created by user on 2021/01/27.
//

import UIKit

class FoFCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var userProfileImgView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var fofCountLabel: UILabel!

    func configureFofCollectionCell(userId: Int, nickname: String, userProto: URL, acquaintance: Int) {
        contentView.layer.cornerRadius = 8
        contentView.layer.borderWidth = 1
        contentView.layer.borderColor = UIColor.darkGray.cgColor
        contentView.clipsToBounds = true
        userProfileImgView.layer.cornerRadius = userProfileImgView.frame.height/2
        userProfileImgView.kf.setImage(with: userProto)

        fofCountLabel.text = "함께 아는 친구 \(acquaintance)명"
        userNameLabel.text = nickname
    }
}
