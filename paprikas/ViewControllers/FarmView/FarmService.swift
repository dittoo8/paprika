//
//  FarmService.swift
//  paprikas
//
//  Created by 박소현 on 2021/01/25.
//

import Foundation

class FarmService {
    func requestFarmUser(isTo: Bool, whenIfFailed: @escaping (Error) -> Void, completionHandler: @escaping ([User]) -> Void) {
        APIClient.requestFarm(isTo: isTo) { result in
            switch result {
            case .success(let farmResult):
                if APIClient.networkingResult(statusCode: farmResult.status!, msg: farmResult.message!) {
                    completionHandler(farmResult.data!)
                }
            case .failure(let error):
                print("error : \(error.localizedDescription)")
                whenIfFailed(error)
            }

        }

    }
}
protocol FarmView: class {
    func setFarmData()
}
class FarmPresenter {
    private let farmService: FarmService
    private weak var farmView: FarmView?
    private let sections: [String] = ["알 수도 있는 친구", CONSTANT_KO.BEST_FRIEND_TO, CONSTANT_KO.BEST_FRIEND_FROM]
    private var fromMeList = [User]()
    private var toMeList = [User]()
    init(farmService: FarmService) {
        self.farmService = farmService
    }
    func attachView(view: FarmView) {
        farmView = view
    }
    func requestFarmData() {
        farmService.requestFarmUser(isTo: true, whenIfFailed: { error in
            print("to farm service error - \(error)")
        }, completionHandler: { toMeResult in
            self.toMeList = toMeResult
            print("request to farm")
            self.farmService.requestFarmUser(isTo: false, whenIfFailed: { error in
                print("to farm service error - \(error)")
            }, completionHandler: { fromMeResult in
                self.fromMeList = fromMeResult
                print("request from farm")
                self.farmView?.setFarmData()
            })
        })
    }

    // MARK: - TableView Methods
    func numberOfRows(in section: Int) -> Int {
        if section == 0 {
            return 1
        } else if section == 1 {
            return toMeList.count
        } else if section == 2 {
            return fromMeList.count
        } else {
            return 0
        }
    }
    func configureRankingCell(_ cell: FarmTableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            cell.backgroundColor = .blue
        } else if indexPath.section == 1 {
            let user = toMeList[indexPath.row]
            if let userId = user.userid, let nickname = user.nickname, let photo = user.userphoto {
                guard let photoUrl = URL(string: photo) else { return }
                cell.configureCell(userId: userId, nickname: nickname, userphoto: photoUrl)
            }
        } else if indexPath.section == 2 {
            let user = fromMeList[indexPath.row]
            if let userId = user.userid, let nickname = user.nickname, let photo = user.userphoto {
                guard let photoUrl = URL(string: photo) else { return }
                cell.configureCell(userId: userId, nickname: nickname, userphoto: photoUrl)
            }
        }
    }
    func numberOfSections() -> Int {
        return sections.count
    }
    func titleForHeaderSection(section: Int) -> String {
        return sections[section]
    }

}
