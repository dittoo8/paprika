//
//  FollowViewController.swift
//  paprikas
//
//  Created by 박소현 on 2021/01/23.
//

import UIKit

class FollowViewController: BaseViewController {

    @IBOutlet weak var followListTableView: UITableView!

    let presenter = FollowPresenter(followService: FollowService())
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.attachView(view: self)
        followListTableView.delegate = self
        followListTableView.dataSource = self
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        presenter.loadFollowAction()
    }

}
extension FollowViewController: FollowView {
    func setFollowViewData(followData: UserListData, isFollowing: Bool) {
        self.navigationItem.title = CONSTANT_KO.USER_FOLLOW(nickname: followData.nickname!, isFollowing: isFollowing)
        self.followListTableView.reloadData()
    }
}
extension FollowViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.numberOfRows(in: section)
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CONSTANT_VC.FOLLOW_TABLE_CELL, for: indexPath) as! FollowTableViewCell
        presenter.configureCell(cell, forRowAt: indexPath)

        let userProfileTap = goToProfileTap(target: self, action: #selector(goToProfileVC(param:)))
        userProfileTap.userId = cell.tag
        cell.isUserInteractionEnabled = true
        cell.contentView.addGestureRecognizer(userProfileTap)
        return cell
    }
}
