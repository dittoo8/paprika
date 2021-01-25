//
//  Constants.swift
//  paprikas
//
//  Created by 박소현 on 2021/01/04.
//

import Foundation
import UIKit

enum CONSTANT_VC {
    static let FEED = "FeedVC"
    static let SEARCH = "SearchVC"
    static let NEW_CONTENT = "NewContentVC"
    static let FARM = "FarmVC"
    static let PROFILE = "ProfileVC"
    static let LOGIN = "LoginVC"
    static let MAIN_TAB_BAR = "MainTabBar"
    static let CONTENT_DETAIL = "ContentDetailVC"
    static let FEED_COLLECTION_CELL = "FeedCollectionViewCell"
    static let COMMENT_TALBE_CELL = "CommentTableViewCell"
    static let FOLLOW_TABLE_CELL = "FollowTableViewCell"
    static let PROFILE_HEADER_CELL = "ProfileHeaderCell"
    static let PROFILE_COLLECTION_FEED_CELL = "ProfileCollectionFeedCell"
}
enum CONSTANT_KO {
    static let NEW_CONTENT_PLACEHOLDER: String = "이곳에 내용을 입력해주세요."
    static let NEW_CONTENT: String = "새 게시물"
    static let PHOTO_PREVIEW: String = "사진 미리보기"
    static let RESELECT_PHOTO: String = "사진 재선택"
    static let CANCEL: String = "취소"
    static let FEED = "피드"
    static let SEARCH = "검색"
    static let FARM = "팜"
    static let MY_PROFILE = "내 프로필"
    static let COMMENT = "댓글"
    static let DO_UN_FOLLOW = "팔로우 끊기"
    static let DO_FOLLOW = "팔로우 하기"
    static let LOG_OUT = "로그아웃"
    static func USERS_CONTENT(user: String) -> String {
        return "\(user)님의 게시물"
    }
    static func PEOPLE_LIKE_COUNT(count: Int) -> String {
        return "\(count)명이 좋아합니다."
    }
    static func SHOW_ALL_COMMENT(count: Int) -> String {
        return "\(count)개의 댓글 모두보기"
    }
    static func USER_FOLLOW(nickname: String, isFollowing: Bool) -> String {
        switch isFollowing {
        case true:
            return "\(nickname)님의 팔로잉"
        case false:
            return "\(nickname)님의 팔로워"
        }

    }
    static func CONTENT_COUNT(count: Int) -> String {
        return "\(count)\n게시물"
    }
    static func FOLLOWER_COUNT(count: Int) -> String {
        return "\(count)\n팔로워"
    }
    static func FOLLOWING_COUNT(count: Int) -> String {
        return "\(count)\n팔로잉"
    }
    static let NO_COMMENT = "아직 댓글이 없습니다."
    static let FIRST_COMMENT = "첫번째 댓글을 작성해보세요."
    static let BEST_FRIEND_TO = "내가 가장 관심을 많이 가진 친구 TOP 5"
    static let BEST_FRIEND_FROM = "나에게 가장 관심을 많이 가진 친구 TOP 5"
    static let MY_FARM = "나의 농장"

}
enum CONSTANT_EN {
    static let MY_TOKEN: String = "myToken"
    static let MY_PHOTO: String = "myPhoto"
    static let MY_ID: String = "myId"
    static let MESSAGE: String = "message"
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
        static let SESSION_EXPIRED: String = "📣 로그아웃되었습니다. 다시 로그인해주세요."
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
