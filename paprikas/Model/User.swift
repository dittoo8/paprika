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
}
struct FollowResult: Codable {
    let status: Int?
    let success: Bool?
    let message: String?
    let data: FollowData?
}
struct FollowData: Codable {
    let followCount: Int?
    let followList: [User]?
}
struct User: Codable {
    let userphoto: String?
    let nickname: String?
    let userid: Int?
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
struct ProfileFeedResult: Codable {
    let status: Int?
    let success: Bool?
    let message: String?
    let data: ProfileFeedData?
}
struct ProfileFeedData: Codable {
    let contentId: Int?
    let url: String?
    let photoCount: Int?
}
