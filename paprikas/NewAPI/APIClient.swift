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
    @discardableResult
    private static func performRequest<T: Decodable>(route: APIRouter, decoder: JSONDecoder = JSONDecoder()) -> Future<T, Error> {
        return Future { completion in
            AF.request(route)
                .responseDecodable(decoder: decoder, completionHandler: { (response: DataResponse<T, AFError>) in
                    switch response.result {
                    case .success(let value):
                        completion(.success(value))
                    case .failure(let error):
                        completion(.failure(error))
                    }
                })
        }
    }

    static func getContentDetail(contentId: Int, completion: @escaping (Result<ContentResult, AFError>) -> Void) {
            let jsonDecoder = JSONDecoder()

            AF.request(APIRouter.content(id: contentId))
                .responseDecodable(decoder: jsonDecoder) { (response: DataResponse<ContentResult, AFError>) in
                    completion(response.result)
            }
        }
}
