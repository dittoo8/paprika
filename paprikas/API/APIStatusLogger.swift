//
//  APIStatusLogger.swift
//  paprikas
//
//  Created by 박소현 on 2021/01/04.
//

import Foundation
import Alamofire

final class APIStatusLogger: EventMonitor {
    let queue = DispatchQueue(label: "APIStatusLogger")
    func request(_ request: DataRequest, didParseResponse response: DataResponse<Data?, AFError>) {
        guard let statusCode = request.response?.statusCode else { return }
        print("APIStatusLogger - statusCode: \(statusCode)")
    }
}
