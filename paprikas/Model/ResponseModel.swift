//
//  CommonModel.swift
//  paprikas
//
//  Created by 박소현 on 2021/01/21.
//

import Foundation

struct ResponseModel: Codable {
    let status: Int?
    let success: Bool?
    let message: String?
}
