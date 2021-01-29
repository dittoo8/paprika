//
//  FeedCollectionViewCell.swift
//  paprikas
//
//  Created by 박소현 on 2021/01/04.
//
import Foundation
import UIKit
import ImageSlideshow
import Kingfisher
class FeedCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var userDetailView: UIView!
    @IBOutlet weak var userProfileImgView: UIImageView! {
        didSet {
            self.userProfileImgView.layer.cornerRadius = self.userProfileImgView.frame.height/2
            self.userProfileImgView.clipsToBounds = true
        }
    }
    @IBOutlet weak var contentImgSlideView: ImageSlideshow!
    @IBOutlet weak var userNickNameLabel: UILabel!
    @IBOutlet weak var likeCountLabel: UILabel!
    @IBOutlet weak var contentTextLabel: UILabel!
    @IBOutlet weak var commentCountLabel: UILabel!
    @IBOutlet weak var contentDateLabel: UILabel!
    @IBOutlet weak var contentFunctionView: UIView!
    @IBOutlet weak var likeBtn: UIButton!
    @IBOutlet weak var commentBtn: UIButton!
    @IBOutlet weak var contentDetailContainView: UIView!

    func configureWith(content: Content) {
        var contentImgs = [KingfisherSource]()
        guard let imgList = content.photo else { return }
        for img in imgList {
            let imgurl = URL(string: img)
            contentImgs.append(KingfisherSource(url: imgurl!))
        }
        contentImgSlideView.contentScaleMode = .scaleAspectFill
        contentImgSlideView.setImageInputs(contentImgs)

        userNickNameLabel.text = content.user?.nickname
        guard let profileImgUrl = URL(string: (content.user?.userphoto)!) else { return }
        userProfileImgView.kf.setImage(with: profileImgUrl)

        let attributedString = NSMutableAttributedString()
            .bold((content.user?.nickname)!, fontSize: 17)
            .normal(" \(content.content?.text ?? "")", fontSize: 17)
        contentTextLabel.attributedText = attributedString
        tag = (content.content?.contentid)!
        likeCountLabel.text = CONSTANT_KO.PEOPLE_LIKE_COUNT(count: content.likeCount ?? 0)
        likeBtn.isSelected = content.isLike!
        likeBtn.tag = (content.content?.contentid)!
        commentBtn.tag = (content.content?.contentid!)!
        if content.commentCount != 0 {
            commentCountLabel.text = CONSTANT_KO.SHOW_ALL_COMMENT(count: content.commentCount ?? 0)
        } else {
            commentCountLabel.text = CONSTANT_KO.NO_COMMENT
        }
        contentDateLabel.text = content.date
        userDetailView.tag = (content.user?.userid)!
    }
}
