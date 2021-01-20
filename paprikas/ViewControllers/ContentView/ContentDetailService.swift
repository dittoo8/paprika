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

    func requestContentData(idx: Int, whenIfFailed: @escaping (Error) -> Void, completionHandler: @escaping (Content) -> Void) {
        APIClient.getContentDetail(contentId: 2) { result in
            switch result {
            case .success(let contentResult):
                print("networking data : \(contentResult.data)")
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
        print("contentDetail - getContentData idx : \(self.contentId)")
        if let contentId = self.contentId {
            contentDetailService.requestContentData(idx: contentId, whenIfFailed: {_ in
                // errer
            }, completionHandler: { content in
                self.content = content
                self.contentDetailView?.setContentViewData(content: content)
            })
        }
    }
}

let jsonContent = """
{
"user": {
    "nickname": "user1",
    "userphoto": "meta1.jpg",
    "userid": 126
},
"content": {
    "text": "It is  Content 1",
    "contentid": 129
},
"date": "2021-01-07",
"likeCount": 2,
"commentCount": 2,
"photo": [
    "photo1.jpg",
    "photo2.jpg"
],
"comment": [
    {
        "com": {
            "text": "It is  comment 1",
            "commentid": 0
        },
        "user": {
            "nickname": "user2",
            "userphoto": "meta2.jpg",
            "userid": 1
        },
        "date": "2021-01-07"
    }
]
}

""".data(using: .utf8)!
