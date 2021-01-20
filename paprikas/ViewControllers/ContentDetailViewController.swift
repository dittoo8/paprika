//
//  ContentDetailViewController.swift
//  paprikas
//
//  Created by 박소현 on 2021/01/04.
//

import UIKit
import ImageSlideshow
import Alamofire

class ContentDetailViewController: BaseViewController {
    @IBOutlet weak var userProfileView: UIView!
    @IBOutlet weak var userProfileImgView: UIImageView! {
        didSet {
            self.userProfileImgView.layer.cornerRadius = self.userProfileImgView.frame.height/2
            self.userProfileImgView.clipsToBounds = true
        }
    }
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var ContentImgSlide: ImageSlideshow!
    @IBOutlet weak var likeCountLabel: UILabel!
    @IBOutlet weak var contentTextLabel: UILabel!
    @IBOutlet weak var commentCountLabel: UILabel!
    @IBOutlet weak var contentDateLabel: UILabel!
    @IBOutlet weak var likeBtn: UIButton!
    @IBOutlet weak var commentBtn: UIButton!
    @IBOutlet weak var contentScrollView: UIScrollView!

    let presenter = ContentDetailPresenter(contentDetailService: ContentDetailService())
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.isNavigationBarHidden = false
        presenter.attachView(view: self)
        presenter.getContentData()
        likeBtn.setImage(UIImage(named: "HeartButton.png"), for: .normal)
        likeBtn.setImage(UIImage(named: "FullHeartButton.png"), for: .selected)

        let userProfileViewTap = UITapGestureRecognizer(target: self, action: #selector(goToProfile(sender:)))
        userProfileView.addGestureRecognizer(userProfileViewTap)

        let commentDetailTap = UITapGestureRecognizer(target: self, action: #selector(commentViewAction(sender:)))
        commentCountLabel.isUserInteractionEnabled = true
        commentCountLabel.addGestureRecognizer(commentDetailTap)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
    }

    @IBAction func likeBtnClicked(_ sender: UIButton) {
        sender.isSelected.toggle()
        presenter.sendLikeAction(method: sender.isSelected)
    }
    @IBAction func commentBtnClicked(_ sender: Any) {
        goToCommentVC(isWrite: true)
    }
    // MARK: - UIGestureRecognizerDelegate
    @objc func goToProfile(sender: UITapGestureRecognizer) {
        let profileVC = storyboard?.instantiateViewController(withIdentifier: "ProfileVC") as! ProfileViewController
        self.navigationController?.pushViewController(profileVC, animated: true)
    }
    @objc func commentViewAction(sender: UITapGestureRecognizer) {
        goToCommentVC(isWrite: false)
    }
    func goToCommentVC(isWrite: Bool) {
        let commentVC = storyboard?.instantiateViewController(withIdentifier: "CommentVC") as! CommentViewController
        commentVC.presenter.setContentConfig(contentId: presenter.idx, isWrite: isWrite)
        self.navigationController?.pushViewController(commentVC, animated: true)
    }
}
extension ContentDetailViewController: ContentDetailView {
    func setViewData(content: Content) {
        print("contentDetail - setViewData idx : \(content.content?.contentid)")
        self.navigationItem.title = "userName 님의 게시물"
        self.userNameLabel.text = content.user?.nickname
        self.userProfileImgView.image = UIImage(named: (content.user?.userphoto!)!)
        self.ContentImgSlide.contentScaleMode = .scaleAspectFill
        self.ContentImgSlide.setImageInputs([ImageSource(image: UIImage(named: "meta1.jpg")!), ImageSource(image: UIImage(named: "meta2.jpg")!)])
        self.likeCountLabel.text = "\(content.likeCount ?? 0)명이 좋아합니다."

        let attributedcontentText = NSMutableAttributedString()
            .bold("\(content.user?.nickname! ?? "") ", fontSize: 17)
            .normal((content.content?.text)!, fontSize: 17)

        self.contentTextLabel.attributedText = attributedcontentText
        self.commentCountLabel.text = "\(content.commentCount ?? 0)개의 댓글 모두보기"
        self.contentDateLabel.text = content.date
    }
}
