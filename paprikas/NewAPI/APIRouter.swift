//
//  APIRouter.swift
//  paprikas
//
//  Created by 박소현 on 2021/01/20.
//

import Alamofire

enum APIRouter: URLRequestConvertible {
    case content(id: Int)

    // MARK: - HTTPMethod
    private var method: HTTPMethod {
        switch self {
        case .content:
        return .get
        }
    }

    // MARK: - Path
    private var path: String {
        switch self {
        case .content(let id):
            return "/content/\(id)"
        }
    }

    // MARK: - Parameters
    private var parameters: Parameters? {
        switch self {
        case .content:
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
