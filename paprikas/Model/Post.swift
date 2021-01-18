//
//  Post.swift
//  paprikas
//
//  Created by 박소현 on 2021/01/04.
//

import Foundation

struct Post: Codable {
    let contentID: Int
    let contentText: String

    init(contentID: Int, contentText: String) {
        self.contentID = contentID
        self.contentText = contentText
    }
}
