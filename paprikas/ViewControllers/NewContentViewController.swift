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

    var postPhotos = [UIImage]()
    override func viewDidLoad() {
        super.viewDidLoad()
        config()
        self.view.addGestureRecognizer(keyboardDismissTapGesture)
        self.navigationItem.title = "새 게시물"

    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        setImgSlide(selectedImg: postPhotos)
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print("NewContentViewController - viewWillDisappear() called")
    }
    // MARK: - fileprivate Methods
    fileprivate func setImgSlide(selectedImg: [UIImage]) {
        var slidePhotos = [ImageSource]()
        for img in selectedImg {
            slidePhotos.append(ImageSource(image: img))
        }
        self.firstImgView.setImageInputs(slidePhotos)
    }
    fileprivate func config() {
        firstImgView.contentScaleMode = UIViewContentMode.scaleAspectFill
        let recognizer = UITapGestureRecognizer(target: self, action: #selector(self.didTapImgPreview))
        firstImgView.addGestureRecognizer(recognizer)
    }

    @objc func didTapImgPreview() {
        if postPhotos.isEmpty {
            viewImagePicker()
        } else {
            // UIAlertController 초기화
            let actionSheetController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)

            let previewAction = UIAlertAction(title: "사진 미리보기", style: .default, handler: { _ in
                let fullScreenController = self.firstImgView.presentFullScreenController(from: self)
                fullScreenController.slideshow.activityIndicator = DefaultActivityIndicator(style: .medium, color: nil)
            })
            let reSelectAction = UIAlertAction(title: "사진 재선택", style: .default, handler: {_ in
                self.viewImagePicker()
            })

            let cancelAction = UIAlertAction(title: "취소", style: .cancel, handler: nil)
            actionSheetController.addAction(previewAction)
            actionSheetController.addAction(reSelectAction)
            actionSheetController.addAction(cancelAction)

            self.present(actionSheetController, animated: true, completion: nil)

        }
    }
    // image Picker library
    func viewImagePicker() {
        var config = YPImagePickerConfiguration()
        config.screens = [.library, .photo]
        config.library.maxNumberOfItems = 10
        let picker = YPImagePicker(configuration: config)
        picker.didFinishPicking { [unowned picker] items, _ in
            self.postPhotos.removeAll()
            for item in items {
                switch item {
                case .photo(let photo):
                    self.postPhotos.append(photo.image)
                case .video(let video):
                    print(video)
                }
            }
            picker.dismiss(animated: true, completion: nil)
        }
        present(picker, animated: true, completion: nil)
    }
    @IBAction func sendContentClicked(_ sender: Any) {
        if postPhotos.isEmpty {
            self.view.makeToast(NOTIFICATION.TOAST.NO_SELECT_IMG, duration: 1.0, position: .center)
        } else {
            self.tabBarController?.selectedIndex = 0
            // 게시물 작성 api 통신, completion으로 feed 불러오기
            AlamofireManager.shard.uploadContent(text: self.contentTextView.text ?? "", url: self.postPhotos)

            // 현재 뷰에 있는 미디어, 글 지우기
            self.postPhotos.removeAll()
            self.contentTextView.text = ""
        }
    }
    // MARK: - UIGestureRecognizerDelegate
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        view.endEditing(true)
        return true
    }
}
