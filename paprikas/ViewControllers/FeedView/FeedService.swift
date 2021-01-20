//
//  FeedService.swift
//  paprikas
//
//  Created by 박소현 on 2021/01/18.
//

import Foundation
class FeedService {
    func requestPostLike() {
        print("request post like")
    }
    func requestPosts(page: Int, completionHandler: @escaping ([Post]) -> Void) {
        // feed 로 수정해야함
        var posts = [Post]()
        posts.append(Post(contentId: 1, userId: 1, contentText: "gggggg"))
        posts.append(Post(contentId: 2, userId: 2, contentText: "gdgadsgadsgasd"))
        posts.append(Post(contentId: 3, userId: 3, contentText: "gggsdaagsdgdsaagsdadgsadsgasgggg"))
        completionHandler(posts)
//        self.page = page + 1
        //        let parameters = ["page": String(page)]
        //        AF.request("\(Constants.API_BASE_URL)post/", parameters: parameters).responseJSON { response in
        //
        //            if let value = response.value as? [String:AnyObject] {
        //                print(value["data"] as Any)
        //                if let array = value["data"] as? NSArray {
        //                    print(array.count)
        //                    for obj in array {
        //                        if let dict = obj as? NSDictionary {
        //                            guard let id = dict.value(forKey: "id") else { return }
        //                            guard let title = dict.value(forKey: "title") else { return }
        //                            guard let body = dict.value(forKey: "body") else { return }
        //                            print("id : \(id)")
        //                            print("title : \(title)")
        //                            print("body : \(body)")
        //
        //                            self.posts.append(Post(id: id as! Int, title: title as! String, body: body as! String))
//                self.posts.append(Post(contentID: 1, contentText: "kkkkk"))
//                self.posts.append(Post(contentID: 2, contentText: "ggdddggdddggdddggdddggdddggdddggdddggdddggdddggdddggdddggddd"))
//                self.posts.append(Post(contentID: 3, contentText: "ewktjlwejfsdlkdgjlsdakjlewktjlwejfsdlkdgjlsdakjlewktjlwejfsdlkdgjlsdakjlewktjlwejfsdlkdgjlsdakjlewktjlwejfsdlkdgjlsdakjlewktjlwejfsdlkdgjlsdakjl;asljkasdadjsgk"))
        //
        //                        }
        //                    }
        //                }
        //            }
        //        }
    }

}
protocol FeedView: class {
    func goToContentDetailVC(contentId: Int)
    func stopNetworking()
    func finUploadContent()
}
class FeedPresenter {
    var page = 1
    var posts = [Post]()
    private let FeedService: FeedService
    private weak var FeedView: FeedView?
    init(FeedService: FeedService) {
        self.FeedService = FeedService
    }
    func attachView(view: FeedView) {
        FeedView = view
    }
    func refreshData() {
        posts.removeAll()
        self.page = 1
        loadMoreData(page: self.page)
    }
    func loadMoreData(page: Int) {
        self.page = page + 1
        print("append page : \(page)")
        FeedService.requestPosts(page: page) { [weak self] posts in
            self?.posts = posts

        }
        self.FeedView?.stopNetworking()
    }

    func sendLikeAction(method: Bool, idx: Int) {
        print("method : \(method), idx : \(idx)")
        FeedService.requestPostLike()
    }

    // MARK: - CollectionView Methods
    func numberOfRows(in section: Int) -> Int {
      return posts.count
    }

    func configureCell(_ cell: FeedCollectionViewCell, forRowAt indexPath: IndexPath) {
        let post = posts[indexPath.row]
        cell.configureWith(contentId: post.contentId!, userId: post.userId!, contentText: post.contentText!)
        print("index path : \(indexPath.row) , posts.count : \(self.posts.count-1)")
        if indexPath.row >= self.posts.count - 1 {
            loadMoreData(page: self.page)
        }
    }
    func didSelectCollectionViewRowAt(indexPath: IndexPath) {
        let selectedPost = posts[indexPath.row]
        self.FeedView?.goToContentDetailVC(contentId: selectedPost.contentId!)
    }
}
