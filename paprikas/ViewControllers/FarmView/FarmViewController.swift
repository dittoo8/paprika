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
    private let sections: [String] = ["iOS", "AOS"]
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.attachView(view: self)
//        farmTableView.dataSource = self
//        farmTableView.delegate = self
    }

}
extension FarmViewController: FarmView {

}
// extension FarmViewController: UITableViewDelegate, UITableViewDataSource {
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        <#code#>
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        <#code#>
//    }
//
//
// }
