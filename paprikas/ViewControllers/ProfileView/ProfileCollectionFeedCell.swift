//
//  ProfileCollectionFeedCell.swift
//  paprikas
//
//  Created by 박소현 on 2021/01/23.
//

import UIKit
import Kingfisher
class ProfileCollectionFeedCell: UICollectionViewCell {

    @IBOutlet weak var firstImgView: UIImageView!
    @IBOutlet weak var moreImgIcon: UIImageView!
    func configureWith(contentId: Int, photoUrl: URL, photoCount: Int) {
        tag = contentId
        firstImgView.kf.setImage(with: photoUrl)
        if photoCount > 1 {
            moreImgIcon.isHidden = false
        } else {
            moreImgIcon.isHidden = true
        }
    }
}
