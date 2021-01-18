//
//  NewContentDetailViewController.swift
//  paprikas
//
//  Created by 박소현 on 2021/01/06.
//

import UIKit
import ImageSlideshow
class NewContentDetailViewController: UIViewController {

    @IBOutlet weak var imgPreView: ImageSlideshow!

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        print("NewContentDetailViewController - viewWillAppear")
    }
}
