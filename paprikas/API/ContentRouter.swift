////
////  ContentRouter.swift
////  paprikas
////
////  Created by 박소현 on 2021/01/09.
////
//
// import Foundation
// import Alamofire
//
// enum ContentRouter: URLRequestConvertible {
//    case uploadContent(param: Data)
//    case contentDetail(idx: Int)
//    var baseURL: URL {
//        return URL(string: API.BASE_URL + "/content")!
//    }
//    // MARK: - Method
//    var method: HTTPMethod {
//        switch self {
//        case .uploadContent:
//            return .post
//        case .contentDetail:
//            return .get
//        }
//    }
//    // MARK: - EndPoint
//    var endPoint: String {
//        switch self {
//        case .uploadContent:
//            return ""
//        case .contentDetail(let idx):
//            return "/\(idx)"
//        }
//    }
//    // MARK: - Parameters
//    private var parameters: Parameters? {
//        switch self {
//        case .uploadContent(let param):
//            return nil
//        case .contentDetail(let idx):
//            return nil
//        }
//    }
//    func asURLRequest() throws -> URLRequest {
//        let url = baseURL.appendingPathComponent(endPoint)
//        print("AuthRouter = asURLRequest() url : \(url)")
//        var request = URLRequest(url: url)
//        request.method = method
//        request = try URLEncodedFormParameterEncoder().encode(parameters, into: request)
//        return request
//    }
// }
