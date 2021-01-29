//
//  FeedService.swift
//  paprikas
//
//  Created by 박소현 on 2021/01/18.
//

import Foundation
class FeedService {
    func requestPostLike(contentId: Int, isLike: Bool, whenIfFailed: @escaping (Error) -> Void, completionHandler: @escaping () -> Void) {
        APIClient.requestLike(contentId: contentId, isLike: isLike) { result in
            switch result {
            case .success(let likeResult):
                if  APIClient.networkingResult(statusCode: likeResult.status!, msg: likeResult.message!) {
                    completionHandler()
                }
            case .failure(let error):
                print("error : \(error.localizedDescription)")
                whenIfFailed(error)
            }}

    }
    func requestPosts(cursor: String, whenIfFailed: @escaping (Error) -> Void, completionHandler: @escaping (FeedData) -> Void) {
        APIClient.requestFeed(cursor: cursor) { result in
            switch result {
            case .success(let feedResult):
                if APIClient.networkingResult(statusCode: feedResult.status!, msg: feedResult.message!) {
                    completionHandler(feedResult.data!)
                }
            case .failure(let error):
                print("error : \(error.localizedDescription)")
                whenIfFailed(error)
            }

        }
    }

}
protocol FeedView: class {
    func goToContentDetail(contentId: Int)
    func stopNetworking()
    func finUploadContent()
}
class FeedPresenter {
    var page = 1
    var contentList = [Content]()
    var feedInfo: pageInfoData?
    private let FeedService: FeedService
    private weak var FeedView: FeedView?
    init(FeedService: FeedService) {
        self.FeedService = FeedService
    }
    func attachView(view: FeedView) {
        FeedView = view
    }
    func refreshData() {
        contentList.removeAll()
        feedInfo?.cursor = nil
        feedInfo?.hasNextPage = nil
        loadMoreData()
    }
    func loadMoreData() {
        FeedService.requestPosts(cursor: feedInfo?.cursor ?? "null", whenIfFailed: { _ in
            // 에러발생

        }, completionHandler: { feedResult in
            self.contentList += feedResult.contents!
            self.feedInfo = feedResult.pageInfo
            self.FeedView?.stopNetworking()
        })

    }

    func sendLikeAction(isLike: Bool, index: Int) {
        print("method : \(isLike), idx : \(index)")
        FeedService.requestPostLike(contentId: (self.contentList[index].content?.contentid)!, isLike: isLike, whenIfFailed: {_ in
            // 에러발생
        }, completionHandler: {
            // 통신성공

        })
    }

    // MARK: - CollectionView Methods
    func numberOfRows(in section: Int) -> Int {
        return contentList.count
    }

    func configureCell(_ cell: FeedCollectionViewCell, forRowAt indexPath: IndexPath) {
        let post = contentList[indexPath.row]
        cell.configureWith(content: post)
        if feedInfo?.hasNextPage ?? true && indexPath.row >= self.contentList.count - 1 {
            loadMoreData()
        }
    }
    func didSelectCollectionViewRowAt(indexPath: IndexPath) {
        let selectedPost = contentList[indexPath.row]
        self.FeedView?.goToContentDetail(contentId: (selectedPost.content?.contentid)!)
    }
}
