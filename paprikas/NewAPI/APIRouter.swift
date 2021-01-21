//
//  APIRouter.swift
//  paprikas
//
//  Created by 박소현 on 2021/01/20.
//

import Alamofire

enum APIRouter: URLRequestConvertible {
    case login(nickname: String, pwd: String)
    case content(id: Int)
    case commentList(contentId: Int)

    // MARK: - HTTPMethod
    private var method: HTTPMethod {
        switch self {
        case .login:
            return .post
        case .content:
            return .get
        case .commentList:
            return .get
        }
    }

    // MARK: - Path
    private var path: String {
        switch self {
        case .login:
            return "/login"
        case .content(let id):
            return "/content/\(id)"
        case .commentList(let contentId):
            return "/comment/\(contentId)"
        }
    }

    // MARK: - Parameters
    private var parameters: Parameters? {
        switch self {
        case .login(let nickname, let pwd):
            return ["nickname": nickname, "pwd": pwd]
        case .content:
            return nil
        case .commentList:
            return nil
        }
    }

    // MARK: - URLRequestConvertible
    func asURLRequest() throws -> URLRequest {
        let url = try API.BASE_URL.asURL()

        var urlRequest = URLRequest(url: url.appendingPathComponent(path))

        // HTTP Method
        urlRequest.httpMethod = method.rawValue

        // Common Headers
        urlRequest.setValue(ContentType.json.rawValue, forHTTPHeaderField: HTTPHeaderField.acceptType.rawValue)
        urlRequest.setValue(ContentType.json.rawValue, forHTTPHeaderField: HTTPHeaderField.contentType.rawValue)

        // Parameters
        if let parameters = parameters {
            do {
                urlRequest.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: [])
            } catch {
                throw AFError.parameterEncodingFailed(reason: .jsonEncodingFailed(error: error))
            }
        }

        return urlRequest
    }
}
