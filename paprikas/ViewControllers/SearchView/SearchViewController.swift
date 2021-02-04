//
//  SearchViewController.swift
//  paprikas
//
//  Created by 박소현 on 2021/01/04.
//

import UIKit

class SearchViewController: BaseViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var recommendCollectionView: UICollectionView!
    @IBOutlet weak var searchResultTableView: UITableView!
    let presenter = SearchPresenter(searchService: SearchService())
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.attachView(view: self)
        keyboardDismissTapGesture.cancelsTouchesInView = false
        recommendCollectionView.delegate = self
        recommendCollectionView.dataSource = self
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(handleRefresh), for: .valueChanged)
        recommendCollectionView.refreshControl = refreshControl
        searchBar.delegate = self
        searchResultTableView.delegate = self
        searchResultTableView.dataSource = self
        searchResultTableView.isHidden = true
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
    func setSearchResult() {
        self.searchResultTableView.reloadData()
    }

}
extension SearchViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = recommendCollectionView.dequeueReusableCell(withReuseIdentifier: CONSTANT_VC.RECOMMEND_COLLECTION_CELL, for: indexPath) as! RecommendCollectionCell
        presenter.configureCell(cell, forRowAt: indexPath)
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
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
extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.numberOfSearchResultRows(in: section)
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SearchResultTableViewCell", for: indexPath) as! SearchResultTableViewCell
        presenter.configureResultTableCell(cell, forRowAt: indexPath)

        let userProfileTap = goToProfileTap(target: self, action: #selector(goToProfileVC(param:)))
        userProfileTap.userId = cell.tag
        cell.isUserInteractionEnabled = true
        cell.contentView.addGestureRecognizer(userProfileTap)
        return cell
    }

}
extension SearchViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if searchBar.searchTextField.text != "" {
            presenter.loadSearchData(name: searchBar.searchTextField.text!)
        }
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.searchTextField.text != "" {
            presenter.loadSearchData(name: searchBar.searchTextField.text!)
        }
    }
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.setShowsCancelButton(true, animated: true)
        searchResultTableView.isHidden = false
        recommendCollectionView.isHidden = true
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.setShowsCancelButton(false, animated: true)
        searchBar.resignFirstResponder()
        searchResultTableView.isHidden = true
        recommendCollectionView.isHidden = false
        searchBar.searchTextField.text = ""
        presenter.removeSearchResult()
    }
}
