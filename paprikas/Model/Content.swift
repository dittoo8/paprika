//
//  Content.swift
//  paprikas
//
//  Created by 박소현 on 2021/01/09.
//

import Foundation

struct ContentResult: Codable {
    let status: Int?
    let success: Bool?
    let message: String?
    let data: Content?
}
struct Content: Codable {
    let user: User?
    let content: ContentDetail?
    let date: String?
    let likeCount: Int?
    let isLike: Bool?
    let commentCount: Int?
    let isWriter: Bool?
    let photo: [String]?
    let comment: [Comment]?
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
