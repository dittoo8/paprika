//
//  AlamofireManager.swift
//  paprikas
//
//  Created by 박소현 on 2021/01/04.
//

import Foundation
import Alamofire

final class AlamofireManager {
    // singleton
    static let shard = AlamofireManager()
    // interceptor
    let interceptors = Interceptor(adapters: [BaseInterceptor()])
    // logger
    let moniters = [Logger(), APIStatusLogger()] as [EventMonitor]
    // session
    var session: Session
    private init() {
        session = Session(interceptor: interceptors, eventMonitors: moniters)
    }
    func login(nickname: String, pwd: String, completion: @escaping (Result<[Auth], MyError>) -> Void) {
        print("AlamofireManager - login() called")
        self.session
            .request(AuthRouter.login(nickname: nickname, password: pwd))
            .validate(statusCode: 200..<401)
            .responseJSON(completionHandler: { response in
                guard let responseValue = response.value else { return }
                print("responseValue : \(responseValue)")
            })
    }
    // 새 게시물 작성
    // 안돌아갈 것 같음
    func uploadContent(text: String, url: [UIImage]) {
        print("AlamofireManager - uploadContent() called")
        AF.upload(multipartFormData: { multiPart in
            multiPart.append(text.data(using: String.Encoding.utf8)!, withName: "text")
            for (index, img) in url.enumerated() {
                multiPart.append(img.jpegData(compressionQuality: 1)!, withName: "photos[\(index)]", fileName: "photos[\(index)]", mimeType: "image/jpeg")
            }
            }, to: "http://0.0.0.0:5000/test_ios")
                .uploadProgress(queue: .main, closure: { progress in
                    // Current upload progress of file
                    print("Upload Progress: \(progress.fractionCompleted)")
                }).responseJSON(completionHandler: { response in
                    // Do what ever you want to do with response
                        if let error = response.error {
                            print("error : \(error)")
                        }
                        guard let data = response.value else {

                            return
                        }
                    print("return data : \(data)")
                })
    }
}
