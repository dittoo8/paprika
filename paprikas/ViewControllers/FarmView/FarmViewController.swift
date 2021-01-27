//
//  FarmViewController.swift
//  paprikas
//
//  Created by 박소현 on 2021/01/04.
//

import UIKit

class FarmViewController: BaseViewController {
    @IBOutlet weak var farmTableView: UITableView!
    let presenter = FarmPresenter(farmService: FarmService())

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.attachView(view: self)
        farmTableView.dataSource = self
        farmTableView.delegate = self
        self.navigationItem.title = CONSTANT_KO.MY_FARM
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        presenter.requestFarmData()
    }

}
extension FarmViewController: FarmView {
    func setFarmData() {
        farmTableView.reloadData()
        print("set  farm")
    }

}
 extension FarmViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.numberOfRows(in: section)
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        switch indexPath.section {
        case 0:
            let fofCell = tableView.dequeueReusableCell(withIdentifier: "FoFTableViewCell", for: indexPath) as! FoFTableViewCell
            return fofCell
        case 1, 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: "FarmTableViewCell", for: indexPath) as! FarmTableViewCell
            presenter.configureRankingCell(cell, forRowAt: indexPath)
            let userProfileTap = goToProfileTap(target: self, action: #selector(goToProfileVC(param:)))
            userProfileTap.userId = cell.tag
            cell.isUserInteractionEnabled = true
            cell.contentView.addGestureRecognizer(userProfileTap)
            return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: "FarmTableViewCell", for: indexPath) as! FarmTableViewCell
            return cell
        }
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return presenter.numberOfSections()
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return presenter.titleForHeaderSection(section: section)
    }

 }
