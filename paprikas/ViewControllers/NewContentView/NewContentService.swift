//
//  NewContentService.swift
//  paprikas
//
//  Created by user on 2021/01/20.
//

import Foundation
import UIKit
class NewContentService {

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
}
