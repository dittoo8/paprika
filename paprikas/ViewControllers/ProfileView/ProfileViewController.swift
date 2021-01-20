//
//  ProfileViewController.swift
//  paprikas
//
//  Created by 박소현 on 2021/01/04.
//

import UIKit

class ProfileViewController: BaseViewController {

    let presenter = ProfilePresenter(profileService: ProfileService())
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.attachView(view: self)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.navigationController?.isNavigationBarHidden = false
    }

}
extension ProfileViewController: ProfileView {
//    func setProfileViewData(Profile: Profile){
//
//    }
}
