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
        likeBtn.setImage(UIImage(named: "HeartButton.png"), for: .normal)
        likeBtn.setImage(UIImage(named: "FullHeartButton.png"), for: .selected)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        presenter.getContentData()
    }

    @IBAction func removeBtnClicked(_ sender: Any) {
        let alert = UIAlertController(title: "게시글을 삭제할까요?", message: nil, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "네", style: .default, handler: { _ in
            self.presenter.removeContentAction()
        }))
        alert.addAction(UIAlertAction(title: "아니요", style: .cancel, handler: nil))
        self.present(alert, animated: true)
    }
    @IBAction func likeBtnClicked(_ sender: UIButton) {
        sender.isSelected.toggle()
        presenter.sendLikeAction(isLike: sender.isSelected)
    }
}
extension ContentDetailViewController: ContentDetailView {
    func popContentDetailView() {
        popViewController()
    }
    func setTapGesture(userId: Int) {
        let userProfileViewTap = goToProfileTap(target: self, action: #selector(goToProfileVC(param:)))
        userProfileViewTap.userId = userId
        userProfileView.addGestureRecognizer(userProfileViewTap)

        let newCommentTap = goToCommentTap(target: self, action: #selector(goToCommentVC(param:)))
        newCommentTap.contentId = presenter.contentId
        newCommentTap.isWrite = true
        self.commentBtn.addGestureRecognizer(newCommentTap)

        let showCommentTap = goToCommentTap(target: self, action: #selector(goToCommentVC(param:)))
        showCommentTap.contentId = presenter.contentId
        showCommentTap.isWrite = false
        self.commentCountLabel.isUserInteractionEnabled = true
        self.commentCountLabel.addGestureRecognizer(showCommentTap)
    }

    func setContentViewData(content: Content) {
        self.navigationItem.title = CONSTANT_KO.USERS_CONTENT(user: (content.user?.nickname)!)
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
        self.likeCountLabel.text = CONSTANT_KO.PEOPLE_LIKE_COUNT(count: content.likeCount ?? 0)
        self.likeBtn.isSelected = content.isLike!
        let attributedcontentText = NSMutableAttributedString()
            .bold("\(content.user?.nickname! ?? "") ", fontSize: 17)
            .normal((content.content?.text)!, fontSize: 17)
        self.contentTextLabel.attributedText = attributedcontentText
        if content.commentCount != 0 {
            self.commentCountLabel.text = CONSTANT_KO.SHOW_ALL_COMMENT(count: content.commentCount ?? 0)
        } else {
            self.commentCountLabel.text = CONSTANT_KO.NO_COMMENT
        }
        self.contentDateLabel.text = content.date
        self.removeBtn.isHidden = !content.isWriter! ?? true
    }
}
