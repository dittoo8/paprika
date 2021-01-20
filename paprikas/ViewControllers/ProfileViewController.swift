//
//  ProfileViewController.swift
//  paprikas
//
//  Created by 박소현 on 2021/01/04.
//

import UIKit

class ProfileViewController: UIViewController {

    let presenter = ProfilePresenter(profileService: ProfileService())
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.attachView(view: self)
    }

}
extension ProfileViewController: ProfileView {

}
