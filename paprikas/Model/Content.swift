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
    let comment: CommentList?
}
struct User: Codable {
    let userphoto: String?
    let nickname: String?
    let userid: Double?
}
struct CommentList: Codable {
    let commentCount: Int?
    let comment: [Comment]?
}
struct Comment: Codable {
    let com: commentDetail?
    let user: commentUserDetail?
    let date: String?
    let isWriter: Bool?
}
struct ContentDetail: Codable {
    let text: String?
    let contentid: Int?
}
struct commentDetail: Codable {
    let text: String?
    let commentid: Int?
}
struct commentUserDetail: Codable {
    let nickname: String?
    let userphoto: String?
    let userid: Int?
}
