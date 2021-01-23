//
//  FollowViewController.swift
//  paprikas
//
//  Created by 박소현 on 2021/01/23.
//

import UIKit

class FollowViewController: BaseViewController {

    @IBOutlet weak var followListTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        followListTableView.delegate = self
        followListTableView.dataSource = self
    }

}
extension FollowViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FollowTableViewCell", for: indexPath) as! FollowTableViewCell
        return cell
    }
}
