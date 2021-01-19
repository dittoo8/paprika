//
//  CommentTableViewCell.swift
//  paprikas
//
//  Created by 박소현 on 2021/01/14.
//

import UIKit

class CommentTableViewCell: UITableViewCell {

    @IBOutlet weak var commentUserProfileImgView: UIImageView! {
        didSet {
            self.commentUserProfileImgView.layer.cornerRadius = self.commentUserProfileImgView.frame.height/2
            self.commentUserProfileImgView.clipsToBounds = true
        }
    }
    @IBOutlet weak var commentContentLabel: UILabel!
    @IBOutlet weak var swipeDeleteLabel: UILabel!
    var isWriter = false
    func configureWith(commentID: Int, text: String, userID: Int, userNickname: String, userPhoto: String, date: String, isWriter: Bool) {
        commentUserProfileImgView.image = UIImage(named: userPhoto)
        let attributedString = NSMutableAttributedString()
            .bold("\(userNickname)", fontSize: 17)
            .normal(" \(text)", fontSize: 17)
        commentContentLabel.attributedText = attributedString
        if isWriter {
            self.isWriter = true
            swipeDeleteLabel.isHidden = false
        }
        commentUserProfileImgView.tag = userID
        tag = commentID
    }
}
