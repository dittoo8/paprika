//
//  LoginService.swift
//  paprikas
//
//  Created by 박소현 on 2021/01/21.
//

import Foundation
import Alamofire
class LoginService {
    func requestLogin(nickname: String, pwd: String, whenIfFailed: @escaping (Error) -> Void, completionHandler: @escaping (UserToken) -> Void) {
        APIClient.login(nickname: nickname, pwd: pwd) { result in
            switch result {
            case .success(let authResult):
                completionHandler(authResult.data!)
            case .failure(let error):
                print("error : \(error.localizedDescription)")
                whenIfFailed(error)
            }
        }
    }
}
protocol LoginView: class {
    func goToMainTab()
    func makeUserInfoEmptyToast()
}
class LoginPresenter {
    private let LoginService: LoginService
    private weak var LoginView: LoginView?
    init(LoginService: LoginService) {
        self.LoginService = LoginService
    }
    func attachView(view: LoginView) {
        LoginView = view
    }
    func userLoginAction(nickname: String, pwd: String) {
        if nickname == "" || pwd == "" {
            LoginView?.makeUserInfoEmptyToast()
        } else {
            LoginService.requestLogin(nickname: nickname, pwd: pwd, whenIfFailed: { error in
                print("error :\(error)")
            }, completionHandler: { result in
                UserDefaults.standard.set(result.token, forKey: "userToken")
                self.LoginView?.goToMainTab()
            })
        }
    }
}
