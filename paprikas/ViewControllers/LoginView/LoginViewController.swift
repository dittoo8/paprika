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
    @IBOutlet weak var loginBtn: UIButton! {
        didSet {
            self.loginBtn.layer.cornerRadius = self.loginBtn.frame.height/2
            self.loginBtn.layer.borderWidth = 1
            self.loginBtn.layer.borderColor = UIColor.systemGray.cgColor
            self.loginBtn.clipsToBounds = true
        }
    }

    let presenter = LoginPresenter(LoginService: LoginService())

    override func viewDidLoad() {
        super.viewDidLoad()
        print("LoginViewController - viewDidLoad")
        presenter.attachView(view: self)
        self.view.addGestureRecognizer(keyboardDismissTapGesture)
        if UserDefaults.standard.string(forKey: CONSTANT_EN.MY_TOKEN) != nil {
            print("token : \(UserDefaults.standard.string(forKey: CONSTANT_EN.MY_TOKEN))")
            goToMainTab()
        }
    }

    @IBAction func loginBtnClicked(_ sender: Any) {
        print("LoginViewController - loginBtnClicked")
        presenter.userLoginAction(nickname: self.idTextField.text!, pwd: self.passwordTetField.text!)
    }
    @IBAction func signUpBtnClicked(_ sender: Any) {
        guard let url = URL(string: API.SIGN_UP_URL) else { return }
        UIApplication.shared.open(url)
    }
    override func keyboardWillShowHandle(notification: NSNotification) {
    }
    // MARK: - UIGestureRecognizerDelegate
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        view.endEditing(true)
        return true
    }
}
extension LoginViewController: LoginView {
    func goToMainTab() {
        let viewController = storyboard?.instantiateViewController(withIdentifier: CONSTANT_VC.MAIN_TAB_BAR) as? UITabBarController
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
