//
//  ContentDetailService.swift
//  paprikas
//
//  Created by 박소현 on 2021/01/11.
//

import Foundation

class ContentDetailService {

    func requestPostLike(contentId: Int, isLike: Bool, whenIfFailed: @escaping (Error) -> Void, completionHandler: @escaping () -> Void) {
        APIClient.requestLike(contentId: contentId, isLike: isLike) { result in
            switch result {
            case .success(let likeResult):
                if  APIClient.networkingResult(statusCode: likeResult.status!, msg: likeResult.message!) {
                    completionHandler()
                }
            case .failure(let error):
                print("error : \(error.localizedDescription)")
                whenIfFailed(error)
            }}

    }
    func requestContentData(contentId: Int, whenIfFailed: @escaping (Error) -> Void, completionHandler: @escaping (Content) -> Void) {
        APIClient.requestContent(contentId: contentId, method: .get) { result in
            switch result {
            case .success(let contentResult):
                if  APIClient.networkingResult(statusCode: contentResult.status!, msg: contentResult.message!) {
                    completionHandler(contentResult.data!)
                }
            case .failure(let error):
                print("error : \(error.localizedDescription)")
                whenIfFailed(error)
            }
        }
    }
    func requestRemoveContent(contentId: Int, whenIfFailed: @escaping (Error) -> Void, completionHandler: @escaping () -> Void) {
        APIClient.requestContent(contentId: contentId, method: .delete) { result in
            switch result {
            case .success(let result):
                if  APIClient.networkingResult(statusCode: result.status!, msg: result.message!) {
                    completionHandler()
                }
            case .failure(let error):
                print("error : \(error.localizedDescription)")
                whenIfFailed(error)
            }
        }
    }

}
protocol ContentDetailView: class {
    func setTapGesture(userId: Int)
    func setContentViewData(content: Content)
    func popContentDetailView()
}
class ContentDetailPresenter {
    var contentId: Int?
    var content: Content?
    private let contentDetailService: ContentDetailService
    private weak var contentDetailView: ContentDetailView?
    init(contentDetailService: ContentDetailService) {
        self.contentDetailService = contentDetailService
    }
    func setContentConfig(contentId: Int) {
        self.contentId = contentId
    }
    func sendLikeAction(isLike: Bool) {
        if let contentId = content?.content?.contentid {
            print("like method : \(isLike) , idx : \(contentId)")
            contentDetailService.requestPostLike(contentId: contentId, isLike: isLike, whenIfFailed: {_ in
                // 에러발생
            }, completionHandler: {
                // 통신성공
                self.getContentData()
            })
        }
    }
    func attachView(view: ContentDetailView) {
        contentDetailView = view
    }
    func getContentData() {
        if let contentId = self.contentId {
            contentDetailService.requestContentData(contentId: contentId, whenIfFailed: {error in
                print("error : \(error)")
            }, completionHandler: { content in
                self.content = content
                self.contentDetailView?.setContentViewData(content: content)
                self.contentDetailView?.setTapGesture(userId: (self.content?.user?.userid)!)
            })
        }
    }
    func removeContentAction() {
        if let contentId = self.contentId {
            contentDetailService.requestRemoveContent(contentId: contentId, whenIfFailed: {error in
                print("error : \(error)")
            }, completionHandler: {
                self.contentDetailView?.popContentDetailView()
            })
        }
    }
}
