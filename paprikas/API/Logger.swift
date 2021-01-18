//
//  Logger.swift
//  paprikas
//
//  Created by 박소현 on 2021/01/04.
//

import Foundation
import Alamofire

final class Logger: EventMonitor {
    let queue = DispatchQueue(label: "ApiLog")
    func requestDidResume(_ request: Request) {
        print("Logger - requestDidResume()")
        debugPrint(request)
    }
    func request<Value>(_ request: DataRequest, didParseResponse response: DataResponse<Value, AFError>) {
        print("Logger - request.didParseResponse()")
        debugPrint(response)
    }
}
