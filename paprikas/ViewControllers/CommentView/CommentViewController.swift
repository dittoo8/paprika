//
//  CommentViewController.swift
//  paprikas
//
//  Created by 박소현 on 2021/01/13.
//

import Foundation
import Toast_Swift
import UIKit

class CommentViewController: BaseViewController {

    @IBOutlet weak var myProfileImgView: UIImageView! {
        didSet {
            self.myProfileImgView.layer.cornerRadius = self.myProfileImgView.frame.height/2
            self.myProfileImgView.clipsToBounds = true
        }
    }
    @IBOutlet weak var newCommentTextField: UITextField!
    @IBOutlet weak var commentTableView: UITableView!

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
        handleRefresh()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.navigationController?.isNavigationBarHidden = false
        self.tabBarController?.tabBar.isHidden = true
        getKeyboard()
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        self.tabBarController?.tabBar.isHidden = false
        keyboardWillHideHandle()
    }
    // MARK: - selector Methods
    @objc fileprivate func handleRefresh() {
        presenter.loadCommentData()
        stopNetworking()
    }
    // MARK: - UIGestureRecognizerDelegate
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        view.endEditing(true)
        return true
    }
    @IBAction func newCommentBtnAction(_ sender: UIButton) {
        if newCommentTextField.text!.isEmpty {
            self.view.makeToast(NOTIFICATION.TOAST.NO_CONTENT, duration: 1.0, position: .center)
        } else {
            presenter.addNewComment()
        }
    }
}
extension CommentViewController: CommentView {
    func getKeyboard() {
        if presenter.getIsWrite() {
            DispatchQueue.main.asyncAfter(deadline: .now()+0.5) {
                self.newCommentTextField.becomeFirstResponder()
            }
        }
    }
    func stopNetworking() {
        print("stop networking")
        self.commentTableView.reloadData()
        self.commentTableView?.refreshControl?.endRefreshing()
    }
}
extension CommentViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CommentTableViewCell", for: indexPath) as! CommentTableViewCell
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "CommentTableViewCell", for: indexPath) as! CommentTableViewCell
        return presenter.checkEditRow(cell, forRowAt: indexPath)
    }

 }
