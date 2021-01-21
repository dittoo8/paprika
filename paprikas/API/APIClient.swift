//
//  APIClient.swift
//  paprikas
//
//  Created by 박소현 on 2021/01/20.
//

import Foundation
import Alamofire
import PromisedFuture

class APIClient {
    static func login(nickname: String, pwd: String, completion:@escaping (Result<AuthResult, AFError>) -> Void) {
        let jsonDecoder = JSONDecoder()
        AF.request(APIRouter.login(nickname: nickname, pwd: pwd))
            .responseDecodable(decoder: jsonDecoder) { (response: DataResponse<AuthResult, AFError>) in
                    completion(response.result)
        }
    }

    static func requestComment(contentId: Int? = nil, commentId: Int? = nil, text: String? = nil, method: HTTPMethod, completion: @escaping (Result<CommentResult, AFError>) -> Void) {
            let jsonDecoder = JSONDecoder()
        AF.request(APIRouter.comment(contentId: contentId, method: method, commentId: commentId, text: text))
                .responseDecodable(decoder: jsonDecoder) { (response: DataResponse<CommentResult, AFError>) in
                    print("requestComment - response : \(response)")
                    completion(response.result)
        }
    }
    static func requestContent(contentId: Int, method: HTTPMethod, completion: @escaping (Result<ContentResult, AFError>) -> Void) {
            let jsonDecoder = JSONDecoder()
        AF.request(APIRouter.content(contentId: contentId, method: method))
            .responseDecodable(decoder: jsonDecoder) { (response: DataResponse<ContentResult, AFError>) in
                print("requestContent - response : \(response)")
                completion(response.result)
            }
    }
}
