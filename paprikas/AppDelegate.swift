//
//  AppDelegate.swift
//  paprikas
//
//  Created by 박소현 on 2020/12/30.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
//        // window가 없으니 만들어준다.
//        self.window = UIWindow(frame: UIScreen.mainScreen.bounds)
//                
//          // 스토리보드 인스턴스
//          let tutorialStoryboard = UIStoryboard(name: "Tutorial", bundle: nil)
//          // 뷰 컨트롤러 인스턴스
//          let viewController = tutorialStoryboard.instantiateViewControllerWithIdentifier("StoryboardTutorialID")
//
//          // 윈도우의 루트 뷰 컨트롤러 설정
//          self.window?.rootViewController = viewController
//
//          // 이제 화면에 보여주자.
//          self.window?.makeKeyAndVisible()
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }

}
