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
    static let BASE_URL: String = "https://"
}

enum NOTIFICATION {
    enum API {
        static let AUTH_FAIL = "authentication_fail"
    }
    enum TOAST {
        static let NO_SELECT_IMG: String = "📣 공유할 사진을 선택해주세요!"
        static let UPLOAD_SUCCESS: String = "😚 새 게시물을 공유했습니다."
    }
}
