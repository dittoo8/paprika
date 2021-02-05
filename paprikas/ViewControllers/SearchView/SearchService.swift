//
//  SearchService.swift
//  paprikas
//
//  Created by 박소현 on 2021/01/26.
//

import Foundation

class SearchService {
    func requestRecommendFeed(whenIfFailed: @escaping (Error) -> Void, completionHandler: @escaping (Photos) -> Void) {
        APIClient.requestRecommendFeed { result in
            switch result {
            case .success(let recommendFeedResult):
                if  APIClient.networkingResult(statusCode: recommendFeedResult.status!, msg: recommendFeedResult.message!) {
                    completionHandler(recommendFeedResult.data!)
                }
            case .failure(let error):
                print("error : \(error.localizedDescription)")
                whenIfFailed(error)
            }
        }
    }
    func requestSearchUser(name: String, whenIfFailed: @escaping (Error) -> Void, completionHandler: @escaping ([User]) -> Void) {
        APIClient.requestSearchUser(name: name) { result in
            switch result {
            case .success(let userListResult):
                if  APIClient.networkingResult(statusCode: userListResult.status!, msg: userListResult.message!) {
                    completionHandler(userListResult.data!)
                }
            case .failure(let error):
                print("error : \(error.localizedDescription)")
                whenIfFailed(error)
            }
        }
    }
}
protocol SearchView: class {
    func setRecommendFeed()
    func goToContentDetail(contentId: Int)
    func stopNetworking()
    func setSearchResult()
}
class SearchPresenter {
    var recommendFeedData = [PhotoData]()
    var searchUserList = [User]()
    private let SearchService: SearchService
    private weak var searchView: SearchView?
    init(searchService: SearchService) {
        self.SearchService = searchService
    }
    func attachView(view: SearchView) {
        searchView = view
    }
    func refreshData() {
        SearchService.requestRecommendFeed(whenIfFailed: { error in
            // 에러
            print("error : \(error)")
        }, completionHandler: { feedData in
            print("feed data : \(feedData)")
            if feedData.photos?.count ?? 0 > 0 {
                self.recommendFeedData = feedData.photos!
            }
            self.searchView?.stopNetworking()
        })
    }
    func loadSearchData(name: String) {
        SearchService.requestSearchUser(name: name, whenIfFailed: { error in
            print("error : \(error)")
        }, completionHandler: { userList in
            self.searchUserList = userList
          self.searchView?.setSearchResult()
        })
    }
    // MARK: - Collection view Methods
    func numberOfRows(in section: Int) -> Int {
        return recommendFeedData.count
    }

    func configureCell(_ cell: RecommendCollectionCell, forRowAt indexPath: IndexPath) {
        let photo = recommendFeedData[indexPath.row]
        guard let photoUrl = URL(string: (photo.url!)) else { return }
        cell.configureWith(contentId: photo.contentId!, photoUrl: photoUrl, photoCount: photo.photoCount!)
    }
    func didSelectCollectionViewRowAt(indexPath: IndexPath) {
        let selectedPhoto = recommendFeedData[indexPath.row]
        self.searchView?.goToContentDetail(contentId: selectedPhoto.contentId!)
    }
    // MARK: - Search TableView Methods
    func removeSearchResult() {
        self.searchUserList.removeAll()
        self.searchView?.setSearchResult()
    }
    func numberOfSearchResultRows(in section: Int) -> Int {
        return searchUserList.count
    }
    func configureResultTableCell(_ cell: SearchResultTableViewCell, forRowAt indexPath: IndexPath) {
        let user = searchUserList[indexPath.row]
        if let userid = user.userid, let userNickname = user.nickname, let photo = user.userphoto {
            guard let photoUrl = URL(string: photo) else { return }
            cell.configureWith(userID: userid, userNickname: userNickname, userPhoto: photoUrl)
        }
    }
}
