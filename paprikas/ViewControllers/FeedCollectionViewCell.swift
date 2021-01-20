//
//  FeedCollectionViewCell.swift
//  paprikas
//
//  Created by 박소현 on 2021/01/04.
//
import Foundation
import UIKit
import ImageSlideshow
protocol FeedCellType {
    func configureWith(contentId: Int, userId: Int, contentText: String)
}
class FeedCollectionViewCell: UICollectionViewCell, FeedCellType {

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

    // parameter 더 추가될 예정
    func configureWith(contentId: Int, userId: Int, contentText: String) {
        contentImgSlideView.contentScaleMode = .scaleAspectFill
        contentImgSlideView.setImageInputs([ImageSource(image: UIImage(named: "meta1.jpg")!), ImageSource(image: UIImage(named: "meta2.jpg")!)])
        let attributedString = NSMutableAttributedString()
            .bold("ggggg", fontSize: 17)
            .normal(" \(contentText)", fontSize: 17)
        contentTextLabel.attributedText = attributedString
        // tag 는 게시물 id 로 수정해야함
        tag = contentId
        likeBtn.tag = contentId
        userDetailView.tag = userId
    }
}
