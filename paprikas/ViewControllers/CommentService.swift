//
//  CommentService.swift
//  paprikas
//
//  Created by 박소현 on 2021/01/18.
//

import Foundation
class CommentService {

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
}
