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
        followListTableView.delegate = self
        followListTableView.dataSource = self
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.navigationItem.title = "~님의 팔로워"
        presenter.loadFollowAction()
    }

}
extension FollowViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.numberOfRows(in: section)
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FollowTableViewCell", for: indexPath) as! FollowTableViewCell
        presenter.configureCell(cell, forRowAt: indexPath)
        return cell
    }
}
