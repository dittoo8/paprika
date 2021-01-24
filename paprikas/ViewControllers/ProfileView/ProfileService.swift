//
//  ProfileService.swift
//  paprikas
//
//  Created by user on 2021/01/20.
//

import Foundation

class ProfileService {
    func requestProfileInfo(userId: Int, whenIfFailed: @escaping (Error) -> Void, completionHandler: @escaping (ProfileInfoDate) -> Void) {
        APIClient.requestProfileInfo(userId: userId) { result in
            switch result {
            case .success(let profileInfoResult):
                if  APIClient.networkingResult(statusCode: profileInfoResult.status!, msg: profileInfoResult.message!) {
                    completionHandler(profileInfoResult.data!)
                }
            case .failure(let error):
                print("error : \(error.localizedDescription)")
                whenIfFailed(error)
            }
        }
    }
    func requestProfileFeed() {

    }
}
protocol ProfileView: class {
    func setProfileData(profileData: ProfileInfoDate)
}
class ProfilePresenter {
    var userId: Int?
    var profileInfoData: ProfileInfoDate?
    var profileFeedData: ProfileFeedData?
    private let profileService: ProfileService
    private weak var profileView: ProfileView?
    init(profileService: ProfileService) {
        self.profileService = profileService
    }
    func attachView(view: ProfileView) {
        profileView = view
    }
    func setProfileConfig(userId: Int) {
        self.userId = userId
    }
    func getUserId() -> Int {
        return userId!
    }
    func loadProfileInfoData() {
        profileService.requestProfileInfo(userId: self.userId!, whenIfFailed: { error in
            // 에러
            print("error : \(error)")
        }, completionHandler: { infoData in
            self.profileInfoData = infoData
            self.profileView?.setProfileData(profileData: self.profileInfoData!)

        })
    }
    func configureHeader(headerView: ProfileHeaderCell) {

        if let contentCount = profileInfoData?.contentCount, let followerCount = profileInfoData?.followerCount, let followingCount = profileInfoData?.followingCount, let isMe = profileInfoData?.isMe, let isFollowed = profileInfoData?.isFollowed, let userPhoto = profileInfoData?.user?.userphoto {
            guard let userPhotourl = URL(string: userPhoto) else { return }
            headerView.configureView(contentCount: contentCount, followerCount: followerCount, followingCount: followingCount, isMe: isMe, isFollowed: isFollowed, userPhoto: userPhotourl)
        }
    }
}
