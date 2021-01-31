//
//  SearchService.swift
//  paprikas
//
//  Created by 박소현 on 2021/01/26.
//

import Foundation

class SearchService {
    func requestRecommendFeed(userId: Int, whenIfFailed: @escaping (Error) -> Void, completionHandler: @escaping (Photos) -> Void) {
        APIClient.requestProfileFeed(userId: userId) { result in
            switch result {
            case .success(let profileFeedResult):
                if  APIClient.networkingResult(statusCode: profileFeedResult.status!, msg: profileFeedResult.message!) {
                    completionHandler(profileFeedResult.data!)
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
}
class SearchPresenter {
    var userId: Int?
    var recommendFeedData = [PhotoData]()
    private let SearchService: SearchService
    private weak var searchView: SearchView?
    init(searchService: SearchService) {
        self.SearchService = searchService
    }
    func attachView(view: SearchView) {
        searchView = view
    }
    func loadRecommendFeedData() {
        SearchService.requestRecommendFeed(userId: 2, whenIfFailed: { error in
            // 에러
            print("error : \(error)")
        }, completionHandler: { feedData in
            self.recommendFeedData = feedData.photos!
            self.searchView?.setRecommendFeed()

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
        print("didselect")
        let selectedPhoto = recommendFeedData[indexPath.row]
        self.searchView?.goToContentDetail(contentId: selectedPhoto.contentId!)
    }
}
