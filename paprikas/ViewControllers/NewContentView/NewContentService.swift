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
//    func requestNewContent(text: String, photos: [UIImage], whenIfFailed: @escaping (Error) -> Void, completionHandler: @escaping (ContentResult) -> Void) {
    func requestNewContent(text: String, photos: [UIImage]) {
        print("request New Content")
        let headers: HTTPHeaders = [
            "Content-type": "multipart/form-data",
            "Authorization": UserDefaults.standard.string(forKey: "userToken") as! String
        ]

        AF.upload(
            multipartFormData: { multipartFormData in
                multipartFormData.append("안녕~?".data(using: .utf8)!, withName: "text")
                for (idx, img) in photos.enumerated() {
                    multipartFormData.append(img.jpegData(compressionQuality: 0.5)!, withName: "photos", fileName: "file[\(idx)].jpeg", mimeType: "image/jpeg")
                }
        },
            to: "http://paprika-api.onstove.com:8000/api/content", method: .post, headers: headers)
            .response { resp in
                print(resp.description)
                print(resp.debugDescription)

        }
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
    func newContentAction(text: String) {
        NewContentService.requestNewContent(text: text, photos: postPhotos)
    }
}
