//
//  APIRouter.swift
//  paprikas
//
//  Created by 박소현 on 2021/01/20.
//

import Alamofire

enum APIRouter: URLRequestConvertible {
    case login(nickname: String, pwd: String)
    case content(contentId: Int, method: HTTPMethod)
    case comment(contentId: Int? = nil, method: HTTPMethod, commentId: Int? = nil, text: String? = nil)
    case like(contentId: Int, isLike: Bool)
    case followList(userId: Int, isFollowing: Bool)
    case profileInfo(userId: Int)
    case profileFeed(userId: Int)

    // MARK: - HTTPMethod
    private var method: HTTPMethod {
        switch self {
        case .login:
            return .post
        case .content(let contentId, let method):
            return method
        case .comment(let contentId, let method, let commentId, let text):
            return method
        case .like(let contentId, let isLike):
            return .post
        case .followList, .profileInfo, .profileFeed:
            return .get
        }
    }

    // MARK: - Path
    private var path: String {
        switch self {
        case .login:
            return "/login"
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
        }
    }

    // MARK: - Parameters
    private var parameters: Parameters? {
        switch self {
        case .login(let nickname, let pwd):
            return ["nickname": nickname, "pwd": pwd]
        case .content, .like, .followList, .profileInfo, .profileFeed:
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
//        let url = try API.API_BASE.asURL()
        var url: URL?
        if path == "/login" {
            url = try API.AUTH_BASE.asURL()
        } else {
            url = try API.API_BASE.asURL()
        }
        var urlRequest = URLRequest(url: url!.appendingPathComponent(path))

        // HTTP Method
        urlRequest.httpMethod = method.rawValue
        // Common Headers
        urlRequest.setValue(ContentType.json.rawValue, forHTTPHeaderField: HTTPHeaderField.contentType.rawValue)
//        if path != "/login"  && path != "/comment/10" {
//            urlRequest.setValue(UserDefaults.standard.string(forKey: "userToken"), forHTTPHeaderField: HTTPHeaderField.authentication.rawValue)
//        }
        if path != "/login" {
            urlRequest.setValue(UserDefaults.standard.string(forKey: "userToken"), forHTTPHeaderField: HTTPHeaderField.authentication.rawValue)
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
