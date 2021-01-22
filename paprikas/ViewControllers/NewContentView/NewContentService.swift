//
//  NewContentService.swift
//  paprikas
//
//  Created by user on 2021/01/20.
//

import Foundation
import UIKit
import Alamofire
class NewContentService {
    func requestNewContent(text: String, photos: [UIImage], completionHandler: @escaping () -> Void) {
        var imgs = [Data]()
        for uiimage in photos {
            imgs.append(uiimage.jpegData(compressionQuality: 0.5)!)
        }
        APIClient.requestNewContetn(text: text, photos: imgs, completion: { _ in
            completionHandler()
        })
    }

}
protocol NewContentView: class {
    func setImgSlide(selectedImg: [UIImage])
    func configImgSlide()
    func showImagePicker()
    func presentNewContentActionSheet()
}
class NewContentPresenter {
    var postPhotos = [UIImage]()
    private let NewContentService: NewContentService
    private weak var NewContentView: NewContentView?
    init(NewContentService: NewContentService) {
        self.NewContentService = NewContentService
    }
    func attachView(view: NewContentView) {
        NewContentView = view
    }
    func removePhotos() {
        postPhotos.removeAll()
    }
    func appendPhoto(photo: UIImage) {
        postPhotos.append(photo)
    }
    func getPhotos() -> [UIImage] {
        return postPhotos
    }
    func getPhotosIsEmpty() -> Bool {
        return postPhotos.isEmpty
    }
    func tapImgPreviewAction() {
        if getPhotosIsEmpty() {
            NewContentView!.showImagePicker()
        } else {
            NewContentView!.presentNewContentActionSheet()
        }
    }
    func newContentAction(text: String, closure: @escaping () -> Void) {
        NewContentService.requestNewContent(text: text, photos: postPhotos, completionHandler: {
            closure()
        })
    }
}
