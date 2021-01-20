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
    static let BASE_URL: String = "https://00fcb098-a0d7-4420-ad47-d0b48c9fc87b.mock.pstmn.io/api"
}

enum NOTIFICATION {
    enum API {
        static let AUTH_FAIL = "authentication_fail"
    }
    enum TOAST {
        static let NO_SELECT_IMG: String = "📣 공유할 사진을 선택해주세요!"
        static let UPLOAD_SUCCESS: String = "😚 새 게시물을 공유했습니다."
        static let NO_CONTENT: String = "📣 내용을 입력해주세요!"
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
