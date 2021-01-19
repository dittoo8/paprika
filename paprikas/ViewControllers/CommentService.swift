//
//  CommentService.swift
//  paprikas
//
//  Created by 박소현 on 2021/01/18.
//

import Foundation
import Alamofire
class CommentService {

    func requestCommentList(idx: Int, completionHandler: @escaping (CommentList) -> Void) {
        // 통신 추가해야함
        let commentList = try! JSONDecoder().decode(CommentList.self, from: jsonComment)
        completionHandler(commentList)
    }
}
protocol CommentView: class {
}
class CommentPresenter {
    var idx: Int?
    var comments: CommentList?
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
    func loadCommentData() {
        if let idx = idx {
            CommentService.requestCommentList(idx: idx) { [weak self] commentList in
                self?.comments = commentList
            }
        }
    }

    // MARK: - TableView Methods
    func numberOfRows(in section: Int) -> Int {
        return comments?.commentCount ?? 0
    }

    func configureCell(_ cell: CommentTableViewCell, forRowAt indexPath: IndexPath) {
        let comment = comments?.comment?[indexPath.row]
        if let commentID = comment?.com?.commentid, let text = comment?.com?.text, let userID = comment?.user?.userid, let userNickname = comment?.user?.nickname, let userPhoto = comment?.user?.userphoto, let date = comment?.date, let isWriter = comment?.isWriter {
            cell.configureWith(commentID: commentID, text: text, userID: userID, userNickname: userNickname, userPhoto: userPhoto, date: date, isWriter: isWriter)
        }
    }
}

let jsonComment = """
{
"commentCount": 2,
"comment": [
    {
    "com": {
        "text": "It is  comment 1",
        "commentid": 0
    },
    "user": {
        "nickname": "user2",
        "userphoto": "user2.jpg",
        "userid": 2

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
        "userphoto": "user3.jpg",
        "userid": 3
    },
    "date": "2021-01-08",
    "isWriter": false
    }
]

}
""".data(using: .utf8)!
