//
//  FollowService.swift
//  paprikas
//
//  Created by 박소현 on 2021/01/23.
//

import Foundation

 class FollowService {
    func requestFollowList(userId: Int, isFollowing: Bool, whenIfFailed: @escaping (Error) -> Void, completionHandler: @escaping (FollowData) -> Void) {
        APIClient.requestFollow(userId: userId, isFollowing: isFollowing) { result in
            switch result {
            case .success(let followResult):
                if  APIClient.networkingResult(statusCode: followResult.status!, msg: followResult.message!) {
                    completionHandler(followResult.data!)
                }
            case .failure(let error):
                print("error : \(error.localizedDescription)")
                whenIfFailed(error)
            }
        }
    }
 }
 protocol FollowView: class {
    func setFollowViewData(isFollowing: Bool)
 }
 class FollowPresenter {
    var userId: Int?
    var isFollowing: Bool?
    var follows: FollowData?
    private let followService: FollowService
    private weak var followView: FollowView?
    init(followService: FollowService) {
        self.followService = followService
    }
    func attachView(view: FollowView) {
        followView = view
    }
    func setIsFollow(userId: Int, isFollow: Bool) {
        self.isFollowing = isFollow
        self.userId = userId
    }

    func loadFollowAction() {
        followService.requestFollowList(userId: self.userId!, isFollowing: self.isFollowing!, whenIfFailed: { error in
            print("error : \(error)")
        }, completionHandler: { followData in
            if followData.followCount == 0 {
                // 팔로우 0명일때
            } else {
                self.follows = followData
                self.followView?.setFollowViewData(isFollowing: self.isFollowing!)
            }
        })
    }
    // MARK: - TableView Methods
    func numberOfRows(in section: Int) -> Int {
        return follows?.followCount ?? 1
    }

    func configureCell(_ cell: FollowTableViewCell, forRowAt indexPath: IndexPath) {
        let follow = follows?.userList?[indexPath.row]
        if let userid = follow?.userid, let userNickname = follow?.nickname, let userPhoto = follow?.userphoto {
            guard let photoUrl = URL(string: userPhoto) else { return }
            cell.configureWith(userID: userid, userNickname: userNickname, userPhoto: photoUrl)
        }
    }
 }
