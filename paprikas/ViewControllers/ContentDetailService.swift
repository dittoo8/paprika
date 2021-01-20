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
    func setViewData(content: Content)
}
class ContentDetailPresenter {
    var idx: Int = 0
    var content: Content?
    private let contentDetailService: ContentDetailService
    private weak var contentDetailview: ContentDetailView?
    init(contentDetailService: ContentDetailService) {
        self.contentDetailService = contentDetailService
    }
    func setIdx(idx: Int) {
        self.idx = idx
    }
    func sendLikeAction(method: Bool) {
        if let idx = content?.content?.contentid {
            print("like method : \(method) , idx : \(idx)")
            contentDetailService.requestPostLike(method: method, idx: idx)
        }
    }
    func attachView(view: ContentDetailView) {
        contentDetailview = view
    }
    func getContentData() {
        print("contentDetail - getContentData idx : \(self.idx)")
        contentDetailService.requestContentData(idx: self.idx, whenIfFailed: {_ in
            // errer
        }, completionHandler: { content in
            self.content = content
            self.contentDetailview?.setViewData(content: content)
        })

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
