//
//  Content.swift
//  paprikas
//
//  Created by 박소현 on 2021/01/09.
//

import Foundation

struct Content: Codable {
    let user: User?
    let content: ContentDetail?
    let date: String?
    let likeCount: Int?
    let commentCount: Int?
    let photo: [String]?
    let comment: [commentList]?
}
struct User: Codable {
    let userphoto: String?
    let nickname: String?
    let userid: Double?
}
struct ContentDetail: Codable {
    let text: String?
    let contentid: Int?
}
struct commentList: Codable {
    let commentCount: Int?
    let com: commentDetail?
    let user: commentUserDetail?
    let date: String?
    let isWrite: Bool?
}
struct commentDetail: Codable {
    let text: String?
    let userid: Int?
}
struct commentUserDetail: Codable {
    let nickname: String?
    let userphoto: String?
}
