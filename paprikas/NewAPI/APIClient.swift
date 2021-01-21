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

    static func getContentDetail(contentId: Int, completion: @escaping (Result<ContentResult, AFError>) -> Void) {
            let jsonDecoder = JSONDecoder()
            AF.request(APIRouter.content(contentId: contentId))
                .responseDecodable(decoder: jsonDecoder) { (response: DataResponse<ContentResult, AFError>) in
                    completion(response.result)
        }
    }
    static func getCommentList(contentId: Int, completion: @escaping (Result<CommentResult, AFError>) -> Void) {
            let jsonDecoder = JSONDecoder()
            AF.request(APIRouter.commentList(contentId: contentId))
                .responseDecodable(decoder: jsonDecoder) { (response: DataResponse<CommentResult, AFError>) in
                    completion(response.result)
        }
    }
}
