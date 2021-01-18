//
//  CommentViewController.swift
//  paprikas
//
//  Created by 박소현 on 2021/01/13.
//

import Foundation
import UIKit

class CommentViewController: BaseViewController {

    @IBOutlet weak var myProfileImgView: UIImageView!
    @IBOutlet weak var newCommentTextField: UITextField!

    let presenter = CommentPresenter(CommentService: CommentService())
    var isWrite: Bool?
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.attachView(view: self)
        self.newCommentTextField.text = ""
        self.view.addGestureRecognizer(keyboardDismissTapGesture)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.navigationController?.isNavigationBarHidden = false
        self.tabBarController?.tabBar.isHidden = true
        if isWrite ?? false {
            DispatchQueue.main.asyncAfter(deadline: .now()+0.5) {
                print("get keyboard")
                self.newCommentTextField.becomeFirstResponder()
            }
        }
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        self.tabBarController?.tabBar.isHidden = false
        keyboardWillHideHandle()
    }
    // MARK: - UIGestureRecognizerDelegate
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        view.endEditing(true)
        return true
    }
}
extension CommentViewController: CommentView {

}
// extension CommentViewController: UITableViewDelegate, UITableViewDataSource {
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return
//    }
//    
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = feedCollectionView.dequeueReusableCell(withReuseIdentifier: "FeedCollectionViewCell", for: indexPath) as! FeedCollectionViewCell
//    }
// }
