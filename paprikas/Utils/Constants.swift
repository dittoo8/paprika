//
//  Constants.swift
//  paprikas
//
//  Created by 박소현 on 2021/01/04.
//

import Foundation
import UIKit
enum SEGUE_ID {
}

enum API {
    // mock url
//    static let API_BASE: String = "https://00fcb098-a0d7-4420-ad47-d0b48c9fc87b.mock.pstmn.io/api"
    // gateway url
//    static let AUTH_BASE: String = "http://paprika.onstove.com:8282/auth"
//    static let API_BASE: String = "http://paprika.onstove.com:8282/api"

    // direct url
    static let AUTH_BASE: String = "http://paprika-auth.onstove.com:8000/auth"
    static let API_BASE: String = "http://paprika-api.onstove.com:8000/api"
}

enum NOTIFICATION {
    enum API {
        static let NETWORK_ERROR = "network error"
        static let AUTH_FAIL = "Authorization fail"
    }
    enum TOAST {
        static let NO_SELECT_IMG: String = "📣 공유할 사진을 선택해주세요!"
        static let UPLOAD_SUCCESS: String = "😚 새 게시물을 공유했습니다."
        static let NO_CONTENT: String = "📣 내용을 입력해주세요!"
        static let USER_INFO_INVALID: String = "📣 아이디 또는 패스워드를 정확히 입력해주세요."
        static let SESSION_EXPIRED: String = "📣 세션이 만료되었습니다. 다시 로그인해주세요."
        static func IS_ERROR(error: String) -> String {
            return "☠️ \(error) 에러입니다."
        }
    }
}
enum HTTPHeaderField: String {
    case authentication = "Authorization"
    case contentType = "Content-Type"
    case acceptType = "Accept"
    case acceptEncoding = "Accept-Encoding"

}

enum ContentType: String {
    case json = "application/json"
}
