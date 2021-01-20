//
//  MainTabBarController.swift
//  paprikas
//
//  Created by 박소현 on 2021/01/06.
//

import UIKit

class MainTabBarController: UITabBarController, UITabBarControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        delegate = self
        settingVC()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        print("MainTabBar")
        print("selected index : \(selectedIndex)")

    }
    fileprivate func settingVC() {
        let feedVC = UINavigationController(rootViewController: storyboard?.instantiateViewController(withIdentifier: "FeedVC") as! FeedViewController)
        feedVC.tabBarItem.title = "피드"
        let searchVC = UINavigationController(rootViewController: storyboard?.instantiateViewController(withIdentifier: "SearchVC") as! SearchViewController)
        searchVC.tabBarItem.title = "검색"
        let newContentVC = UINavigationController(rootViewController: storyboard?.instantiateViewController(withIdentifier: "NewContentVC") as! NewContentViewController)
        newContentVC.tabBarItem.title = "새 게시물"
        let farmVC = UINavigationController(rootViewController: storyboard?.instantiateViewController(identifier: "FarmVC") as! FarmViewController)
        farmVC.tabBarItem.title = "팜"
        let profileVC = UINavigationController(rootViewController: storyboard?.instantiateViewController(identifier: "ProfileVC") as! ProfileViewController)
        profileVC.tabBarItem.title = "내 프로필"

        setViewControllers([feedVC, searchVC, newContentVC, farmVC, profileVC], animated: true)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    func testTab() {
        let feedNC = self.tabBarController?.viewControllers![0] as! UINavigationController
        let feedVC = feedNC.viewControllers.first as! FeedViewController
        feedVC.handleRefresh()
        print("main tab test")
//        self.tabBarController?.selectedIndex = 0
    }
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        print("selected index : \(selectedIndex)")
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

    }
}
