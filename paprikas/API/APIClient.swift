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
    static func makeErrorToast(error: String) {
        let data = [CONSTANT_EN.MESSAGE: error] as [AnyHashable: String]
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: NOTIFICATION.API.NETWORK_ERROR), object: nil, userInfo: data)
    }

    static func networkingResult(statusCode: Int, msg: String) -> Bool {
        switch statusCode {
        case 200:
            return true
        case 401..<420:
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: NOTIFICATION.API.AUTH_FAIL), object: nil, userInfo: nil)
        default:
            makeErrorToast(error: msg)
        }
        return false
    }

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
                    if response.response?.statusCode != nil {
                        print("requestComment - response : \(response.result)")
                        completion(response.result)
                    } else {
                        makeErrorToast(error: response.error?.errorDescription! ?? "")
                    }
        }
    }
    static func requestFollow(userId: Int, isFollowing: Bool, completion: @escaping (Result<FollowResult, AFError>) -> Void) {
            let jsonDecoder = JSONDecoder()
        AF.request(APIRouter.followList(userId: userId, isFollowing: isFollowing))
                .responseDecodable(decoder: jsonDecoder) { (response: DataResponse<FollowResult, AFError>) in
                    if response.response?.statusCode != nil {
                        print("requestFollowList - response : \(response.result)")
                        completion(response.result)
                    } else {
                        makeErrorToast(error: response.error?.errorDescription! ?? "")
                    }
        }
    }
    static func requestProfileInfo(userId: Int, completion: @escaping (Result<ProfileInfoResult, AFError>) -> Void) {
            let jsonDecoder = JSONDecoder()
        AF.request(APIRouter.profileInfo(userId: userId))
                .responseDecodable(decoder: jsonDecoder) { (response: DataResponse<ProfileInfoResult, AFError>) in
                    if response.response?.statusCode != nil {
                        print("requestProfileInfo - response : \(response.result)")
                        completion(response.result)
                    } else {
                        makeErrorToast(error: response.error?.errorDescription! ?? "")
                    }
        }
    }
    static func requestProfileFeed(userId: Int, completion: @escaping (Result<ProfileFeedResult, AFError>) -> Void) {
            let jsonDecoder = JSONDecoder()
        AF.request(APIRouter.profileFeed(userId: userId))
                .responseDecodable(decoder: jsonDecoder) { (response: DataResponse<ProfileFeedResult, AFError>) in
                    if response.response?.statusCode != nil {
//                        print("requestProfileFeed - response : \(response.result)")
                        completion(response.result)
                    } else {
                        makeErrorToast(error: response.error?.errorDescription! ?? "")
                    }
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
    static func requestLike(contentId: Int, isLike: Bool, completion: @escaping (Result<ResponseModel, AFError>) -> Void) {
            let jsonDecoder = JSONDecoder()
        AF.request(APIRouter.like(contentId: contentId, isLike: isLike))
            .responseDecodable(decoder: jsonDecoder) { (response: DataResponse<ResponseModel, AFError>) in
                print("requestLike - response : \(response)")
                completion(response.result)
            }
    }
    static func requestNewContetn(text: String, photos: [Data], completion: @escaping (Result<Data?, AFError>) -> Void) {
        let headers: HTTPHeaders = [
            "Content-type": "multipart/form-data",
            "Authorization": UserDefaults.standard.string(forKey: CONSTANT_EN.USER_TOKEN)!
        ]

        AF.upload( multipartFormData: { multipartFormData in
                multipartFormData.append(text.data(using: .utf8)!, withName: "text")
                for (idx, img) in photos.enumerated() {
                    multipartFormData.append(img, withName: "photos", fileName: "file[\(idx)].jpeg", mimeType: "image/jpeg")
                }
        }, to: API.API_BASE + "/content", method: .post, headers: headers)
            .response { response in
                print("newContent result : \(response.debugDescription)")
                if response.response?.statusCode != nil {
                    if networkingResult(statusCode: response.response!.statusCode, msg: "\(response.response!.statusCode)") {
                        print("newContent success")
                        completion(response.result)
                    } else {
                        print("newContent error")
                    }
                } else {
                    makeErrorToast(error: response.error?.errorDescription! ?? "")
                }

        }

    }
}
