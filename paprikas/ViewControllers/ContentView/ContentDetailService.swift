//
//  ContentDetailService.swift
//  paprikas
//
//  Created by 박소현 on 2021/01/11.
//

import Foundation

class ContentDetailService {

    func requestPostLike(method: Bool, idx: Int) {
        print("request post like")
    }

    func requestContentData(contentId: Int, whenIfFailed: @escaping (Error) -> Void, completionHandler: @escaping (Content) -> Void) {
        APIClient.getContentDetail(contentId: contentId) { result in
            switch result {
            case .success(let contentResult):
                completionHandler(contentResult.data!)
            case .failure(let error):
                print("error : \(error.localizedDescription)")
                whenIfFailed(error)
            }
        }
    }

}
protocol ContentDetailView: class {
    func setContentViewData(content: Content)
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
    func sendLikeAction(method: Bool) {
        if let idx = content?.content?.contentid {
            print("like method : \(method) , idx : \(idx)")
            contentDetailService.requestPostLike(method: method, idx: idx)
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
            })
        }
    }
}
