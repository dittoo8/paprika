//
//  MainTabBarController.swift
//  paprikas
//
//  Created by 박소현 on 2021/01/06.
//

import UIKit

class MainTabBarController: UITabBarController, UITabBarControllerDelegate {
    var beforeVC = 0
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
        let feedVC = UINavigationController(rootViewController: storyboard?.instantiateViewController(withIdentifier: CONSTANT_VC.FEED) as! FeedViewController)
        feedVC.tabBarItem.title = CONSTANT_KO.FEED
        let searchVC = UINavigationController(rootViewController: storyboard?.instantiateViewController(withIdentifier: CONSTANT_VC.SEARCH) as! SearchViewController)
        searchVC.tabBarItem.title = CONSTANT_KO.SEARCH
        let newContentVC = UINavigationController(rootViewController: storyboard?.instantiateViewController(withIdentifier: CONSTANT_VC.NEW_CONTENT) as! NewContentViewController)
        newContentVC.tabBarItem.title = CONSTANT_KO.NEW_CONTENT
        let farmVC = UINavigationController(rootViewController: storyboard?.instantiateViewController(identifier: CONSTANT_VC.FARM) as! FarmViewController)
        farmVC.tabBarItem.title = CONSTANT_KO.FARM
        let profileVC = UINavigationController(rootViewController: storyboard?.instantiateViewController(identifier: CONSTANT_VC.PROFILE) as! ProfileViewController)
        profileVC.tabBarItem.title = CONSTANT_KO.MY_PROFILE
        let profileView = profileVC.viewControllers.first as! ProfileViewController
        profileView.presenter.setProfileConfig(userId: UserDefaults.standard.integer(forKey: CONSTANT_EN.MY_ID))
        setViewControllers([feedVC, searchVC, newContentVC, farmVC, profileVC], animated: true)
    }

    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        print("selected index : \(selectedIndex)")
        if beforeVC == 0 && selectedIndex == 0 {
            let feedNC = tabBarController.selectedViewController as! UINavigationController
                let feedVC = feedNC.viewControllers.first as? FeedViewController
            feedVC?.feedCollectionView.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
        }
        beforeVC = selectedIndex
    }

}
