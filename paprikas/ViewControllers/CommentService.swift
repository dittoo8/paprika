//
//  CommentService.swift
//  paprikas
//
//  Created by 박소현 on 2021/01/18.
//

import Foundation
class CommentService {
    func requestCommentData() {

    }
}
protocol CommentView: class {
}
class CommentPresenter {
    var idx: Int?
    private let CommentService: CommentService
    private weak var CommentView: CommentView?
    init(CommentService: CommentService) {
        self.CommentService = CommentService
    }
    func attachView(view: CommentView) {
        CommentView = view
    }
    func setIdx(idx: Int) {
        print("set comment idx : \(idx)")
        self.idx = idx
    }
    func getCommentData() {

    }
}

let jsonComment = """
{
"com": {
    "text": "It is  comment 1",
    "commentid": 0
},
"user": {
    "nickname": "user2",
    "userphoto": "user2.jpg"
},
"date": "2021-01-07",
"isWriter": true
},
{
"com": {
    "text": "It is  comment 2",
    "commentid": 1
},
"user": {
    "nickname": "user3",
    "userphoto": "user3.jpg"
},
"date": "2021-01-08",
"isWriter": false
}
""".data(using: .utf8)!
