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
    let contentid: Int?
    let user: User?
    let content: ContentDetail?
    let date: String?
    var likeCount: Int?
    let isLike: Bool?
    let commentCount: Int?
    let isWriter: Bool?
    let photo: [String]?
    let comment: [Comment]?
}
struct FeedResult: Codable {
    let status: Int?
    let success: Bool?
    let message: String?
    let data: FeedData?
}
struct FeedData: Codable {
    let contents: [Content]?
    let pageInfo: pageInfoData?
}
struct pageInfoData: Codable {
    var cursor: String?
    var hasNextPage: Bool?
}
struct ContentDetail: Codable {
    let text: String?
    let contentid: Int?
}
struct CategoryResult: Codable {
    let status: Int?
    let success: Bool?
    let message: String?
    let data: [String]?
}
