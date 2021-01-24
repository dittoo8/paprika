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
    func requestProfileFeed(userId: Int, whenIfFailed: @escaping (Error) -> Void, completionHandler: @escaping (Photos) -> Void) {
        APIClient.requestProfileFeed(userId: userId) { result in
            switch result {
            case .success(let profileFeedResult):
                if  APIClient.networkingResult(statusCode: profileFeedResult.status!, msg: profileFeedResult.message!) {
                    completionHandler(profileFeedResult.data!)
                }
            case .failure(let error):
                print("error : \(error.localizedDescription)")
                whenIfFailed(error)
            }
        }

    }
    func requestFollow(userId: Int, isUnFollow: Bool, whenIfFailed: @escaping (Error) -> Void, completionHandler: @escaping () -> Void) {
        APIClient.requestFollow(userId: userId, isUnFollow: isUnFollow) { result in
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
protocol ProfileView: class {
    func setProfileData(profileData: ProfileInfoDate)
    func setProfileFeed()
    func goToContentDetail(contentId: Int)
}
class ProfilePresenter {
    var userId: Int?
    var profileInfoData: ProfileInfoDate?
    var profileFeedData = [PhotoData]()
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
    func loadProfileFeedData() {
        profileService.requestProfileFeed(userId: self.userId!, whenIfFailed: { error in
            // 에러
            print("error : \(error)")
        }, completionHandler: { feedData in
            self.profileFeedData = feedData.photos!
            self.profileView?.setProfileFeed()

        })
    }
    func followOrSetBtnAction() {
        if (profileInfoData?.isMe)! {
            // 로그아웃
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: NOTIFICATION.API.AUTH_FAIL), object: nil, userInfo: nil)
        } else {
            if (profileInfoData?.isFollowed)! {
                // 팔로우 끊기
                profileService.requestFollow(userId: self.userId!, isUnFollow: true, whenIfFailed: {_ in

                }, completionHandler: {
                    print("팔로우 끊음")
                    self.loadProfileInfoData()
                })
            } else {
//                 팔로우하기
                profileService.requestFollow(userId: self.userId!, isUnFollow: false, whenIfFailed: {_ in

                }, completionHandler: {
                    print("팔로우 함")
                    self.loadProfileInfoData()
                })

            }
        }
    }
    // MARK: - Collection view Methods
    func numberOfRows(in section: Int) -> Int {
        return profileFeedData.count
    }
    func configureHeader(headerView: ProfileHeaderCell) {

        if let userId = profileInfoData?.user?.userid, let contentCount = profileInfoData?.contentCount, let followerCount = profileInfoData?.followerCount, let followingCount = profileInfoData?.followingCount, let isMe = profileInfoData?.isMe, let isFollowed = profileInfoData?.isFollowed, let userPhoto = profileInfoData?.user?.userphoto {
            guard let userPhotourl = URL(string: userPhoto) else { return }
            headerView.configureView(userId: userId, contentCount: contentCount, followerCount: followerCount, followingCount: followingCount, isMe: isMe, isFollowed: isFollowed, userPhoto: userPhotourl)
        }
    }
    func configureCell(_ cell: ProfileCollectionFeedCell, forRowAt indexPath: IndexPath) {
        let photo = profileFeedData[indexPath.row]
        guard let photoUrl = URL(string: (photo.url!)) else { return }
        cell.configureWith(contentId: photo.contentId!, photoUrl: photoUrl, photoCount: photo.photoCount!)
    }
    func didSelectCollectionViewRowAt(indexPath: IndexPath) {
        let selectedPhoto = profileFeedData[indexPath.row]
        self.profileView?.goToContentDetail(contentId: selectedPhoto.contentId!)
    }
}
