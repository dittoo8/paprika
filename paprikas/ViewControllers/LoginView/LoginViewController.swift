//
//  ViewController.swift
//  paprikas
//
//  Created by 박소현 on 2020/12/30.
//

import UIKit
import Toast_Swift
import Alamofire

class LoginViewController: BaseViewController {
    @IBOutlet weak var idTextField: UITextField!
    @IBOutlet weak var passwordTetField: UITextField!

    let presenter = LoginPresenter(LoginService: LoginService())

    override func viewDidLoad() {
        super.viewDidLoad()
        print("LoginViewController - viewDidLoad")
        presenter.attachView(view: self)
        if UserDefaults.standard.string(forKey: "userToken") != nil {
            goToMainTab()
        }
    }

    @IBAction func loginBtnClicked(_ sender: Any) {
        print("LoginViewController - loginBtnClicked")
        presenter.userLoginAction(nickname: self.idTextField.text!, pwd: self.passwordTetField.text!)
    }
}
extension LoginViewController: LoginView {
    func goToMainTab() {
        let viewController = storyboard?.instantiateViewController(withIdentifier: "MainTabBar") as? UITabBarController
        UIApplication.shared.windows.first?.rootViewController = viewController
        UIApplication.shared.windows.first?.makeKeyAndVisible()
    }
    func makeUserInfoEmptyToast() {
        self.makeToast(message: NOTIFICATION.TOAST.USER_INFO_INVALID)
    }
    func tokenExpiredToast() {
        self.makeToast(message: NOTIFICATION.TOAST.SESSION_EXPIRED)
    }

}
