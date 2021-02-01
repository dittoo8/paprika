//
//  SearchViewController.swift
//  paprikas
//
//  Created by 박소현 on 2021/01/04.
//

import UIKit

class SearchViewController: BaseViewController {

    @IBOutlet weak var userSearchBar: UISearchBar!
    @IBOutlet weak var recommendCollectionView: UICollectionView!
    let presenter = SearchPresenter(searchService: SearchService())
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.attachView(view: self)
        self.view.addGestureRecognizer(keyboardDismissTapGesture)
        keyboardDismissTapGesture.cancelsTouchesInView = false
        recommendCollectionView.delegate = self
        recommendCollectionView.dataSource = self
        userSearchBar.delegate = self
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(handleRefresh), for: .valueChanged)
        recommendCollectionView.refreshControl = refreshControl

    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.navigationController?.isNavigationBarHidden = true
        handleRefresh()
    }
    // MARK: - selector Methods
    @objc func handleRefresh() {
        print("searchVC - handleRefresh")
        presenter.refreshData()
    }
    override func keyboardWillShowHandle(notification: NSNotification) {
    }
    // MARK: - UIGestureRecognizerDelegate
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        view.endEditing(true)
        return true
    }

}
extension SearchViewController: SearchView {
    func stopNetworking() {
        self.recommendCollectionView.reloadData()
        self.recommendCollectionView?.refreshControl?.endRefreshing()
    }

    func setRecommendFeed() {
        self.recommendCollectionView.reloadData()
    }

    func goToContentDetail(contentId: Int) {
        goToContentDetailVC(contentId: contentId)
    }

}
extension SearchViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = recommendCollectionView.dequeueReusableCell(withReuseIdentifier: CONSTANT_VC.RECOMMEND_COLLECTION_CELL, for: indexPath) as! RecommendCollectionCell
        presenter.configureCell(cell, forRowAt: indexPath)
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("did select")
        presenter.didSelectCollectionViewRowAt(indexPath: indexPath)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (self.view.frame.width/3)-1
        let cellsize = CGSize(width: width, height: width)
        return cellsize
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter.numberOfRows(in: section)
    }
}
extension SearchViewController: UISearchBarDelegate {

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        print("text : \(searchBar.searchTextField.text)")
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print("did change : \(searchBar.searchTextField.text )")
    }
}
