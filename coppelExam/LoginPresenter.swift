//
//  LoginPresenter.swift
//  coppelExam
//
//  Created by MacBook Air on 24/02/23.
//

import UIKit
import FirebaseAuth

protocol LoginPresenterProtocol {
    func showLoading()
    func hideLoading()
    func presentError(error: Error)
    func presentNextScreen(navigationController: UINavigationController, view: UIViewController)
    func goLogin(response: AuthDataResult?, error: Error?, navigationController: UINavigationController?)
}

final class LoginPresenter {
    var view: LoginViewProtocol?
    let decoder = JSONDecoder()
    let loadingView = LoadingView()
    let misc = Misc()
}

extension LoginPresenter: LoginPresenterProtocol {
    func goLogin(response: AuthDataResult?, error: Error?, navigationController: UINavigationController?) {
        if let err = error {
            self.presentError(error: err)
            return
        }else {
            if let res = response {
                self.configureMoviesView(email: res.user.email ?? String(), uid: res.user.uid, navigationController: navigationController)
            }else{
                let error: Error = NSError(domain: misc.localizedString(forKey: "ce_login_error"), code: 1)
                self.presentError(error: error)
            }
        }
    }
    
    func showLoading() {
        loadingView.createLoader()
    }
    
    func hideLoading() {
        loadingView.dismissLoader()
    }
    
    func presentError(error: Error) {
        view?.presentError(error: error)
        hideLoading()
    }
    
    func presentNextScreen(navigationController: UINavigationController, view: UIViewController) {
        navigationController.pushViewController(view, animated: true)
    }
    
    private func configureMoviesView(email: String, uid: String, navigationController: UINavigationController?) {
        self.hideLoading()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            let moviesVC = MoviesViewController().configuredView(email: email, uid: uid)
            self.presentNextScreen(navigationController: navigationController!, view: moviesVC)
        }
    }
}
