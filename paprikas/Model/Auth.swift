//
//  Auth.swift
//  paprikas
//
//  Created by 박소현 on 2021/01/04.
//

import Foundation

struct Auth: Codable {
    let nickname: String
    let pwd: String
    let token: String
    init(nickname: String, pwd: String, token: String) {
        self.nickname = nickname
        self.pwd = pwd
        self.token = token
    }
}
