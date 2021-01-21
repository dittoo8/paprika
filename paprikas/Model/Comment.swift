//
//  Comment.swift
//  paprikas
//
//  Created by 박소현 on 2021/01/18.
//

import Foundation

struct CommentResult: Codable {
    let status: Int?
    let success: Bool?
    let message: String?
    let data: CommentList?
}
struct CommentList: Codable {
    let commentCount: Int?
    var comment: [Comment]?
}
struct Comment: Codable {
    let com: commentDetail?
    let user: commentUserDetail?
    let date: String?
    let isWriter: Bool?
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
