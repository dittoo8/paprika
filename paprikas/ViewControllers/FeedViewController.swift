//
//  FeedViewController.swift
//  paprikas
//
//  Created by 박소현 on 2021/01/04.
//

import UIKit
import Alamofire
import Toast_Swift
import ImageSlideshow

class FeedViewController: BaseViewController {

    @IBOutlet weak var feedCollectionView: UICollectionView!

    let presenter = FeedPresenter(FeedService: FeedService())

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.attachView(view: self)

        feedCollectionView.delegate = self
        feedCollectionView.dataSource = self

        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(handleRefresh), for: .valueChanged)
        feedCollectionView.refreshControl = refreshControl
        handleRefresh()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = true
        print("FeedVC - viewWillAppear")

    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        print("FeedVC - viewWillDisappear")
    }
    // MARK: - selector Methods
    @objc fileprivate func handleRefresh() {
        presenter.refreshData()
        stopNetworking()
    }

    @objc func likeBtnClicked(sender: UIButton) {
        sender.isSelected.toggle()
        presenter.sendLikeAction(method: sender.isSelected, idx: sender.tag)
    }
    @objc func goToCommentVC(param: CustomTapGesture) {
        print("go to comment vc")
        let commentVC = storyboard?.instantiateViewController(withIdentifier: "CommentVC") as! CommentViewController
        commentVC.isWrite = param.isWrite
        commentVC.presenter.setIdx(idx: param.idx!)
        self.navigationController?.pushViewController(commentVC, animated: true)
    }
}
extension FeedViewController: FeedView {
    func stopNetworking() {
        print("stop networking")
        self.feedCollectionView.reloadData()
        self.feedCollectionView?.refreshControl?.endRefreshing()
    }

    func goToContentDetailVC(idx: Int) {
        let contentDetailVC = storyboard?.instantiateViewController(withIdentifier: "ContentDetailVC") as! ContentDetailViewController
        contentDetailVC.presenter.setIdx(idx: idx)
        self.navigationController?.pushViewController(contentDetailVC, animated: true)

    }
}
extension FeedViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    // MARK: - collectionView Methods
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter.numberOfRows(in: section)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presenter.didSelectCollectionViewRowAt(indexPath: indexPath)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = self.view.frame.width
        let height = width + 300
        let cellsize = CGSize(width: width, height: height)
        return cellsize
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = feedCollectionView.dequeueReusableCell(withReuseIdentifier: "FeedCollectionViewCell", for: indexPath) as! FeedCollectionViewCell
        presenter.configureCell(cell, forRowAt: indexPath)

        cell.likeBtn.addTarget(self, action: #selector(likeBtnClicked(sender: )), for: .touchUpInside)

        let newCommentTap = CustomTapGesture(target: self, action: #selector(self.goToCommentVC(param:)))
        newCommentTap.idx = cell.tag
        newCommentTap.isWrite = true
        cell.commentBtn.addGestureRecognizer(newCommentTap)

        let showCommentTap = CustomTapGesture(target: self, action: #selector(self.goToCommentVC(param:)))
        showCommentTap.idx = cell.tag
        showCommentTap.isWrite = false
        cell.commentCountLabel.isUserInteractionEnabled = true
        cell.commentCountLabel.addGestureRecognizer(showCommentTap)

        return cell
    }
}
class CustomTapGesture: UITapGestureRecognizer {
    var idx: Int?
    var isWrite: Bool?
}
