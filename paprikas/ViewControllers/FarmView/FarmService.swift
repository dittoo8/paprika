//
//  FarmService.swift
//  paprikas
//
//  Created by 박소현 on 2021/01/25.
//

import Foundation

class FarmService {

}
protocol FarmView: class {
}
class FarmPresenter {
    private let farmService: FarmService
    private weak var farmView: FarmView?
    init(farmService: FarmService) {
        self.farmService = farmService
    }
    func attachView(view: FarmView) {
        farmView = view
    }

}
