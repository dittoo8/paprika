//
//  APIRouter.swift
//  paprikas
//
//  Created by 박소현 on 2021/01/20.
//

import Alamofire

enum APIRouter: URLRequestConvertible {
    case login(nickname: String, pwd: String)
    case logout
    case content(contentId: Int, method: HTTPMethod)
    case comment(contentId: Int? = nil, method: HTTPMethod, commentId: Int? = nil, text: String? = nil)
    case like(contentId: Int, isLike: Bool)
    case followList(userId: Int, isFollowing: Bool)
    case profileInfo(userId: Int)
    case profileFeed(userId: Int)
    case follow(userId: Int, isUnfollow: Bool)
    case farm(isTo: Bool)
    case category
    case feed(cursor: String)
    case friendOfFriend

    // MARK: - HTTPMethod
    private var method: HTTPMethod {
        switch self {
        case .login, .follow:
            return .post
        case .content(let contentId, let method):
            return method
        case .comment(let contentId, let method, let commentId, let text):
            return method
        case .like(let contentId, let isLike):
            return .post
        case .followList, .profileInfo, .profileFeed, .farm, .category, .logout, .feed, .friendOfFriend:
            return .get
        }
    }

    // MARK: - Path
    private var path: String {
        switch self {
        case .login:
            return "/login"
        case .logout:
            return "/logout"
        case .content(let contentId, let method):
            return "/content/\(contentId)"
        case .comment(let contentId, let method, let commentId, let text):
            switch method {
            case .get:
                return "/comment/\(contentId!)"
            case .post:
                return "/comment/\(contentId!)"
            case .delete:
                return "/comment/\(commentId!)"
            default:
                return ""
            }
        case .like(let contentId, let isLike):
            switch isLike {
            case true:
                return "/like/\(contentId)"
            case false:
                return "/like/cancle/\(contentId)"
            }
        case .followList(let userId, let isFollowing):
            switch isFollowing {
            case true:
                return "/follow/to/\(userId)"
            default:
                return "/follow/from/\(userId)"
            }
        case .profileInfo(let userId):
            return "/profile/\(userId)"
        case .profileFeed(let userId):
            return "/profile/feed/\(userId)"
        case .follow(let userId, let isUnfollow):
            switch isUnfollow {
            case true:
                return "/follow/un/\(userId)"
            default:
                return "/follow/do/\(userId)"
            }
        case .farm(let isTo):
            switch isTo {
            case true:
                return "/farm/best/to"
            case false:
                return "/farm/best/from"
            }
        case .category:
            return "/content/get/category"
        case .feed:
            return "/feed"
        case .friendOfFriend:
            return "/farm/know"
        }
    }

    // MARK: - Parameters
    private var parameters: Parameters? {
        switch self {
        case .login(let nickname, let pwd):
            return ["nickname": nickname, "pwd": pwd, "devicetoken": UserDefaults.standard.string(forKey: CONSTANT_EN.DEVICE_TOKEN)!]
        case .content, .like, .followList, .profileInfo, .profileFeed, .follow, .farm, .category, .logout, .feed, .friendOfFriend:
            return nil
        case .comment(let contentId, let method, let commentId, let text):
            switch method {
            case .get, .delete:
                return nil
            case .post:
                return ["text": text!]
            default:
                return nil
            }
        }
    }

    // MARK: - URLRequestConvertible
    func asURLRequest() throws -> URLRequest {
        var url: URL?
        switch self {
        case .login, .logout:
            url = try API.AUTH_BASE.asURL()
        default:
            url = try API.API_BASE.asURL()
        }
        var urlRequest = URLRequest(url: url!.appendingPathComponent(path))

        // HTTP Method
        urlRequest.httpMethod = method.rawValue
        // Common Headers
        urlRequest.setValue(ContentType.json.rawValue, forHTTPHeaderField: HTTPHeaderField.contentType.rawValue)

        switch self {
        case .feed(let cursor):
            urlRequest.setValue(UserDefaults.standard.string(forKey: CONSTANT_EN.MY_TOKEN), forHTTPHeaderField: HTTPHeaderField.authentication.rawValue)
            urlRequest.setValue(cursor, forHTTPHeaderField: "cursor")
        case .login:
            break
        default:
            urlRequest.setValue(UserDefaults.standard.string(forKey: CONSTANT_EN.MY_TOKEN), forHTTPHeaderField: HTTPHeaderField.authentication.rawValue)
        }

        // Parameters
        if let parameters = parameters {
            do {
                urlRequest.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: [])
            } catch {
                throw AFError.parameterEncodingFailed(reason: .jsonEncodingFailed(error: error))
            }
        }
        print("request url : \(urlRequest) , method : \(method.rawValue)")
        return urlRequest
    }
}
