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
    func configureWith(contentId: Int, photoUrl: URL) {
        tag = contentId
        firstImgView.kf.setImage(with: photoUrl)
    }
}
