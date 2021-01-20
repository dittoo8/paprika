//
//  Post.swift
//  paprikas
//
//  Created by 박소현 on 2021/01/04.
//

import Foundation

struct Post: Codable {
    let contentId: Int?
    let userId: Int?
    let contentText: String?
}
