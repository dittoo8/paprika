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

    func config() {
        fofCountLabel.text = "함께 아는 친구 3명"
        contentView.layer.cornerRadius = 8
        contentView.layer.borderWidth = 1
        contentView.layer.borderColor = UIColor.darkGray.cgColor
        contentView.clipsToBounds = true
        userProfileImgView.layer.cornerRadius = userProfileImgView.frame.height/2
    }
}
