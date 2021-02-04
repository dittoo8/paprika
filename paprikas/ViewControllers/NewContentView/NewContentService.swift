//
//  NewContentService.swift
//  paprikas
//
//  Created by user on 2021/01/20.
//

import Foundation
import UIKit

class NewContentService {
    func requestNewContent(text: String, photos: [UIImage], category: [String], completionHandler: @escaping () -> Void) {
        var imgs = [Data]()
        for uiimage in photos {
            imgs.append(uiimage.jpegData(compressionQuality: 0.5)!)
        }
        APIClient.requestNewContetn(text: text, photos: imgs, category: category, completion: { _ in
            completionHandler()
        })
    }
}
protocol NewContentView: class {
    func setImgSlide(selectedImg: [UIImage])
    func configImgSlide()
    func showImagePicker()
    func presentNewContentActionSheet()
    func refreshCategorys()
}
class NewContentPresenter {
    var postPhotos = [UIImage]()
    var categorys: [String] = ["animal", "food", "travel", "culture", "home", "activity", "entertainment", "emotion", "fashion", "daily"]
    var selectedCategory = [String]()
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
    func getCategorys() {
        self.NewContentView?.refreshCategorys()
    }
    func tapImgPreviewAction() {
        if getPhotosIsEmpty() {
            NewContentView!.showImagePicker()
        } else {
            NewContentView!.presentNewContentActionSheet()
        }
    }
    func removeSelectedCategorys() {
        NewContentView?.refreshCategorys()
        selectedCategory.removeAll()
    }
    func newContentAction(text: String, closure: @escaping () -> Void) {
        NewContentService.requestNewContent(text: text, photos: postPhotos, category: selectedCategory, completionHandler: {
            self.removeSelectedCategorys()
            closure()
        })
    }
    func numberOfRows(in section: Int) -> Int {
        return categorys.count
    }
    func configureCell(_ cell: CategoryCollectionViewCell, forRowAt indexPath: IndexPath) {
        let category = categorys[indexPath.row]
        cell.configureCell(categoryName: category)
    }
    func didSelectCollectionViewRowAt(_ cell: CategoryCollectionViewCell, indexPath: IndexPath) {
        let category = categorys[indexPath.row]
        if self.selectedCategory.contains(category) {
            self.selectedCategory = self.selectedCategory.filter({ $0 != category})
            cell.unselectCell()
        } else {
            self.selectedCategory.append(category)
            cell.selectCell()
        }
        print("all : \(self.selectedCategory)")
    }
}
