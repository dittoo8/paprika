//
//  ProfileService.swift
//  paprikas
//
//  Created by user on 2021/01/20.
//

import Foundation

class ProfileService {

}
protocol ProfileView: class {
}
class ProfilePresenter {
    var userId: Int?
//    var Profile:
    private let profileService: ProfileService
    private weak var profileView: ProfileView?
    init(profileService: ProfileService) {
        self.profileService = profileService
    }
    func attachView(view: ProfileView) {
        profileView = view
    }
    func setProfileConfig(userId: Int) {
        self.userId = userId
    }
    func getUserId() -> Int {
        return userId!
    }
}
