//
//  ProfileHeaderCell.swift
//  Pods
//
//  Created by 박소현 on 2021/01/23.
//

import UIKit

class ProfileHeaderCell: UICollectionReusableView {

    @IBOutlet weak var userProfileImgView: UIImageView! {
        didSet {
            self.userProfileImgView.layer.cornerRadius = self.userProfileImgView.frame.height/2
            self.userProfileImgView.clipsToBounds = true
        }
    }
    @IBOutlet weak var followOrSettingBtn: UIButton!
    @IBOutlet weak var contentInfoView: UIView!
    @IBOutlet weak var contentInfoLabel: UILabel!
    @IBOutlet weak var followerInfoView: UIView!
    @IBOutlet weak var followerInfoLabel: UILabel!
    @IBOutlet weak var followingInfoView: UIView!
    @IBOutlet weak var followingInfoLabel: UILabel!

}
