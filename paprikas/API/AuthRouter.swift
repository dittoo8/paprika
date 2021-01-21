//
//  AuthRouter.swift
//  paprikas
//
//  Created by 박소현 on 2021/01/04.
//

import Foundation
import Alamofire

enum AuthRouter: URLRequestConvertible {
    case login(nickname: String, password: String)
    case logout
    var baseURL: URL {
        return URL(string: API.API_BASE + "/auth")!
    }
    var method: HTTPMethod {
        switch self {
        case .login:
            return .post
        case .logout:
            return .get
        }
    }
    var endPoint: String {
        switch self {
        case .login:
            return "/login"
        case .logout:
            return "/logout"
        }
    }
    var parameters: [String: String] {
        switch self {
        case let .login(nickname, password):
            return ["nickname": nickname, "password": password]
        case .logout:
            return [:]
        }
    }
    func asURLRequest() throws -> URLRequest {
        let url = baseURL.appendingPathComponent(endPoint)
        print("AuthRouter = asURLRequest() url : \(url)")
        var request = URLRequest(url: url)
        request.method = method
        request = try URLEncodedFormParameterEncoder().encode(parameters, into: request)
        return request
    }
}
