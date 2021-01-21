//
//  ContentDetailViewController.swift
//  paprikas
//
//  Created by 박소현 on 2021/01/04.
//

import UIKit
import ImageSlideshow
import Kingfisher

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
    @IBOutlet weak var removeBtn: UIButton!

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

    @IBAction func removeBtnClicked(_ sender: Any) {
        presenter.removeContentAction()
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
        commentVC.presenter.setContentConfig(contentId: presenter.contentId!, isWrite: isWrite)
        self.navigationController?.pushViewController(commentVC, animated: true)
    }
}
extension ContentDetailViewController: ContentDetailView {
    func setContentViewData(content: Content) {
        self.navigationItem.title = "\(content.user?.nickname! ?? "")님의 게시물"
        self.userNameLabel.text = content.user?.nickname
        guard let profileImgUrl = URL(string: (content.user?.userphoto)!) else { return }
        self.userProfileImgView.kf.setImage(with: profileImgUrl)
        self.ContentImgSlide.contentScaleMode = .scaleAspectFill

        var contentImgs = [KingfisherSource]()
        guard let imgList = content.photo else { return }
        for img in imgList {
            let imgurl = URL(string: img)
            contentImgs.append(KingfisherSource(url: imgurl!))
        }
        self.ContentImgSlide.setImageInputs(contentImgs)
        self.likeCountLabel.text = "\(content.likeCount ?? 0)명이 좋아합니다."
        self.likeBtn.isSelected = content.isLike!
        let attributedcontentText = NSMutableAttributedString()
            .bold("\(content.user?.nickname! ?? "") ", fontSize: 17)
            .normal((content.content?.text)!, fontSize: 17)
        self.contentTextLabel.attributedText = attributedcontentText
        if content.commentCount != 0 {
            self.commentCountLabel.text = "\(content.commentCount ?? 0)개의 댓글 모두보기"
        } else {
            self.commentCountLabel.text = "아직 댓글이 없습니다."
        }
        self.contentDateLabel.text = content.date
        self.removeBtn.isHidden = content.isWriter ?? false
    }
}
