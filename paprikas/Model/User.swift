//
//  Auth.swift
//  paprikas
//
//  Created by 박소현 on 2021/01/04.
//

import Foundation

struct AuthResult: Codable {
    let status: Int?
    let success: Bool?
    let message: String?
    let data: UserToken?
}
struct UserToken: Codable {
    let token: String?
    let userid: Int?
    let userphoto: URL?
}
struct FollowResult: Codable {
    let status: Int?
    let success: Bool?
    let message: String?
    let data: UserListData?
}
struct UserListData: Codable {
    let nickname: String?
    let followCount: Int?
    let followList: [User]?
}
struct FoFResult: Codable {
    let status: Int?
    let success: Bool?
    let message: String?
    let data: [User]?
}
struct UserResult: Codable {
    let status: Int?
    let success: Bool?
    let message: String?
    let data: [User]?
}
struct User: Codable {
    let userphoto: String?
    let nickname: String?
    let userid: Int?
    let acquaintance: Int?
}
struct ProfileInfoResult: Codable {
    let status: Int?
    let success: Bool?
    let message: String?
    let data: ProfileInfoDate?
}
struct ProfileInfoDate: Codable {
    let user: User?
    let isMe: Bool?
    let contentCount: Int?
    let followerCount: Int?
    let followingCount: Int?
    let isFollowed: Bool?
}
struct PhotoFeedResult: Codable {
    let status: Int?
    let success: Bool?
    let message: String?
    let data: Photos?
}
struct Photos: Codable {
    let pageInfo: pageInfoData?
    let photos: [PhotoData]?
}
struct PhotoData: Codable {
    let contentId: Int?
    let url: String?
    let photoCount: Int?
}
