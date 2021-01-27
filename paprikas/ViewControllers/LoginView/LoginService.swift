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
        print("ddasgdlagsdljkadgsasdgklj")
        APIClient.login(nickname: nickname, pwd: pwd) { result in
            print("result ??? : \(result)")
            print("====")
            switch result {
            case .success(let authResult):
                if  APIClient.networkingResult(statusCode: authResult.status!, msg: authResult.message!) {
                    completionHandler(authResult.data!)
                }
            case .failure(let error):
                print("gggg")
//                print("error : \(error.localizedDescription)")
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
                UserDefaults.standard.set(result.token, forKey: CONSTANT_EN.DEVICE_TOKEN)
                UserDefaults.standard.set(result.token, forKey: CONSTANT_EN.MY_TOKEN)
                UserDefaults.standard.set(result.userphoto, forKey: CONSTANT_EN.MY_PHOTO)
                UserDefaults.standard.set(result.userid, forKey: CONSTANT_EN.MY_ID)
                self.LoginView?.goToMainTab()
            })
        }
    }
}
