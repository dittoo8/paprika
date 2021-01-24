//
//  ProfileHeaderCell.swift
//  Pods
//
//  Created by 박소현 on 2021/01/23.
//

import UIKit
import Kingfisher
class ProfileHeaderCell: UICollectionReusableView {

    @IBOutlet weak var userProfileImgView: UIImageView! {
        didSet {
            self.userProfileImgView.layer.cornerRadius = self.userProfileImgView.frame.height/2
            self.userProfileImgView.clipsToBounds = true
        }
    }
    @IBOutlet weak var followOrSettingBtn: UIButton! {
        didSet {
            self.followOrSettingBtn.layer.cornerRadius = 5
            self.followOrSettingBtn.clipsToBounds = true
            self.followOrSettingBtn.layer.borderWidth = 1
            self.followOrSettingBtn.layer.borderColor = UIColor.darkGray.cgColor
        }
    }
    @IBOutlet weak var contentInfoView: UIView!
    @IBOutlet weak var contentInfoLabel: UILabel!
    @IBOutlet weak var followerInfoView: UIView!
    @IBOutlet weak var followerInfoLabel: UILabel!
    @IBOutlet weak var followingInfoView: UIView!
    @IBOutlet weak var followingInfoLabel: UILabel!

    func configureView(userId: Int, contentCount: Int, followerCount: Int, followingCount: Int, isMe: Bool, isFollowed: Bool, userPhoto: URL) {
        tag = userId
        userProfileImgView.kf.setImage(with: userPhoto)
        contentInfoLabel.text = "\(contentCount)\n게시물"
        followerInfoLabel.text = "\(followerCount)\n팔로워"
        followingInfoLabel.text = "\(followingCount)\n팔로잉"
        if isMe {
            followOrSettingBtn.text("로그아웃")
        } else {
            if isFollowed {
                followOrSettingBtn.text("팔로우 끊기")
            } else {
                followOrSettingBtn.text("팔로우 하기")
                followOrSettingBtn.backgroundColor = UIColor.systemTeal
            }
        }
        if followerCount > 0 {
            followerInfoView.isUserInteractionEnabled = true
        } else {
            followerInfoView.isUserInteractionEnabled = false
        }
        if followingCount > 0 {
            followingInfoView.isUserInteractionEnabled = true
        } else {
            followingInfoView.isUserInteractionEnabled = false
        }
    }

}
