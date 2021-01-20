//
//  ViewController.swift
//  paprikas
//
//  Created by 박소현 on 2020/12/30.
//

import UIKit
import Toast_Swift
import Alamofire

class LoginViewController: UIViewController {
    // 유저가 입력한 로그인 아이디, 패스워드
    @IBOutlet weak var idTextField: UITextField!
    @IBOutlet weak var passwordTetField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        print("LoginViewController - viewDidLoad")
        changeRootVC()
    }
    fileprivate func changeRootVC() {
        // change rootVC to MainTabbarController
        let viewController = storyboard?.instantiateViewController(withIdentifier: "MainTabBar") as? UITabBarController
        UIApplication.shared.windows.first?.rootViewController = viewController
        UIApplication.shared.windows.first?.makeKeyAndVisible()
    }

    @IBAction func loginBtnClicked(_ sender: Any) {
        print("LoginViewController - loginBtnClicked")
        if idTextField.text == "" || passwordTetField.text == "" {
            self.view.makeToast("📣 아이디 또는 패스워드를 정확히 입력해주세요.", duration: 1.0, position: .center)
        } else {
            let inputId = idTextField.text ?? ""
            let inputPassword = passwordTetField.text ?? ""
            print("id : \(inputId) , pwd : \(inputPassword)")
            //        AlamofireManager.shard.login(nickname: inputId, pwd: inputPassword, completion: { [weak self] result in
            //            guard let self = self else { return }
            //            switch result {
            //            case .success(let loginUser):
            //                print("login success")
            //            case . failure(let error):
            //                print("error : \(error.rawValue)")
            //            }
            //        })
            changeRootVC()
        }

    }
}
