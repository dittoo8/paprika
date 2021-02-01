//
//  CommentViewController.swift
//  paprikas
//
//  Created by 박소현 on 2021/01/13.
//

import Foundation
import UIKit
import Kingfisher
class CommentViewController: BaseViewController {

    @IBOutlet weak var myProfileImgView: UIImageView! {
        didSet {
            self.myProfileImgView.layer.cornerRadius = self.myProfileImgView.frame.height/2
            self.myProfileImgView.clipsToBounds = true
        }
    }
    @IBOutlet weak var newCommentView: UIView!
    @IBOutlet weak var newCommentTextField: UITextField!
    @IBOutlet weak var commentTableView: UITableView!
    @IBOutlet weak var noCommentLabel: UILabel!

    let presenter = CommentPresenter(CommentService: CommentService())

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.attachView(view: self)
        self.newCommentTextField.text = ""
        self.view.addGestureRecognizer(keyboardDismissTapGesture)
        commentTableView.delegate = self
        commentTableView.dataSource = self

        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(handleRefresh), for: .valueChanged)
        commentTableView.refreshControl = refreshControl
        self.noCommentLabel.text = CONSTANT_KO.FIRST_COMMENT
        self.myProfileImgView.kf.setImage(with: UserDefaults.standard.url(forKey: CONSTANT_EN.MY_PHOTO))
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.navigationController?.isNavigationBarHidden = false
        self.tabBarController?.tabBar.isHidden = true
        self.navigationItem.title = CONSTANT_KO.COMMENT
        presenter.loadCommentData()
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        getKeyboard()
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        self.tabBarController?.tabBar.isHidden = false
        keyboardWillHideHandle()
    }
    // MARK: - selector Methods
    @objc fileprivate func handleRefresh() {
        presenter.refreshData()
    }
    // MARK: - UIGestureRecognizerDelegate
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        if touch.view?.isDescendant(of: commentTableView) == true {
            view.endEditing(true)
        }
        return true
    }

    @IBAction func newCommentBtnAction(_ sender: UIButton) {
        if newCommentTextField.text!.isEmpty {
            self.makeToast(message: NOTIFICATION.TOAST.NO_CONTENT)
        } else {
            presenter.addNewComment(text: newCommentTextField.text!) {
                self.newCommentTextField.text = ""
                self.view.endEditing(true)
            }
        }
    }
}
extension CommentViewController: CommentView {
    func getKeyboard() {
        if presenter.getIsWrite() {
            self.newCommentTextField.becomeFirstResponder()
            presenter.toggleIsWrite()
        }
    }
    func stopNetworking() {
        print("commentTable stop networking")
        self.commentTableView.reloadData()
        self.commentTableView?.refreshControl?.endRefreshing()
    }
    func toggleTableView(method: Bool) {
        self.noCommentLabel.isHidden = !method
        commentTableView.isHidden = method
    }
}
extension CommentViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CONSTANT_VC.COMMENT_TALBE_CELL, for: indexPath) as! CommentTableViewCell
        presenter.configureCell(cell, forRowAt: indexPath)

        let userProfileTap = goToProfileTap(target: self, action: #selector(goToProfileVC(param:)))
        userProfileTap.userId = cell.commentUserProfileImgView.tag
        cell.commentUserProfileImgView.isUserInteractionEnabled = true
        cell.commentUserProfileImgView.addGestureRecognizer(userProfileTap)
        return cell
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.numberOfRows(in: section)
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        presenter.removeCommentCell(tableView, commit: .delete, forRowAt: indexPath)
    }
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        let cell = tableView.dequeueReusableCell(withIdentifier: CONSTANT_VC.COMMENT_TALBE_CELL, for: indexPath) as! CommentTableViewCell
        return presenter.checkEditRow(cell, forRowAt: indexPath)
    }

 }
