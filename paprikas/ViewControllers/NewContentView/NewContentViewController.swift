//
//  NewContentViewController.swift
//  paprikas
//
//  Created by 박소현 on 2021/01/04.
//

import UIKit
import Alamofire
import YPImagePicker
import ImageSlideshow
import Toast_Swift
class NewContentViewController: BaseViewController {

    @IBOutlet weak var firstImgView: ImageSlideshow!
    @IBOutlet weak var contentTextView: UITextView!

    let presenter = NewContentPresenter(NewContentService: NewContentService())

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.attachView(view: self)
        configImgSlide()
        self.view.addGestureRecognizer(keyboardDismissTapGesture)
        contentTextView.delegate = self
        contentTextView.text = "이곳에 내용을 입력해주세요."
        contentTextView.textColor = UIColor.lightGray
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.navigationItem.title = "새 게시물"
        setImgSlide(selectedImg: presenter.getPhotos())
    }
    // MARK: - selector Methods
    @objc func didTapImgPreview() {
        presenter.tapImgPreviewAction()
    }

    @IBAction func sendContentClicked(_ sender: Any) {
        if presenter.getPhotosIsEmpty() {
            self.makeToast(message: NOTIFICATION.TOAST.NO_SELECT_IMG)
        } else {
            // 게시물 작성 api 통신, completion으로 feed 불러오기
            presenter.newContentAction(text: contentTextView.text ?? "")
            let navVC = tabBarController?.viewControllers![0] as! UINavigationController
            let feedVC = navVC.topViewController as! FeedViewController
            feedVC.finUploadContent()
            tabBarController?.selectedIndex = 0

            presenter.removePhotos()
            self.contentTextView.text = ""
        }
    }
    // MARK: - UIGestureRecognizerDelegate
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        view.endEditing(true)
        return true
    }
}
extension NewContentViewController: NewContentView {
    func configImgSlide() {
        firstImgView.contentScaleMode = UIViewContentMode.scaleAspectFill
        let recognizer = UITapGestureRecognizer(target: self, action: #selector(self.didTapImgPreview))
        firstImgView.addGestureRecognizer(recognizer)
    }
    func setImgSlide(selectedImg: [UIImage]) {
        var slidePhotos = [ImageSource]()
        for img in selectedImg {
            slidePhotos.append(ImageSource(image: img))
        }
        self.firstImgView.setImageInputs(slidePhotos)
    }
    func showImagePicker() {
        var config = YPImagePickerConfiguration()
        config.screens = [.library, .photo]
        config.library.maxNumberOfItems = 10
        let picker = YPImagePicker(configuration: config)
        picker.didFinishPicking { [unowned picker] items, _ in
            self.presenter.removePhotos()
            for item in items {
                switch item {
                case .photo(let photo):
                    self.presenter.appendPhoto(photo: photo.image)
                case .video(let video):
                    print(video)
                }
            }
            picker.dismiss(animated: true, completion: nil)
        }
        present(picker, animated: true, completion: nil)
    }
    func presentNewContentActionSheet() {
        let newContentActionSheetController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)

        let previewAction = UIAlertAction(title: "사진 미리보기", style: .default, handler: { _ in
            let fullScreenController = self.firstImgView.presentFullScreenController(from: self)
            fullScreenController.slideshow.activityIndicator = DefaultActivityIndicator(style: .medium, color: nil)
        })
        let reSelectAction = UIAlertAction(title: "사진 재선택", style: .default, handler: {_ in
            self.showImagePicker()
        })

        let cancelAction = UIAlertAction(title: "취소", style: .cancel, handler: nil)
        newContentActionSheetController.addAction(previewAction)
        newContentActionSheetController.addAction(reSelectAction)
        newContentActionSheetController.addAction(cancelAction)

        self.present(newContentActionSheetController, animated: true, completion: nil)
    }
}
 extension NewContentViewController: UITextViewDelegate {
    // TextView Place Holder
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray {
            textView.text = nil
            textView.textColor = UIColor.black
        }

    }
    // TextView Place Holder
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "이곳에 내용을 입력해주세요."
            textView.textColor = UIColor.lightGray
        }
    }
 }
