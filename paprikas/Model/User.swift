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
    let userList: [User]?
}
struct User: Codable {
    let userphoto: String?
    let nickname: String?
    let userid: Int?
}
