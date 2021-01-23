//
//  FollowService.swift
//  paprikas
//
//  Created by 박소현 on 2021/01/23.
//

import Foundation

 class FollowService {
    func requestFollowList() {

    }
 }
 protocol FollowView: class {
 }
 class FollowPresenter {
    var userId: Int?
    private let followService: FollowService
    private weak var followView: FollowView?
    init(followService: FollowService) {
        self.followService = followService
    }
    func attachView(view: FollowView) {
        followView = view
    }
 }
