//
//  LoginInteractor.swift
//  coppelExam
//
//  Created by MacBook Air on 24/02/23.
//

import Foundation
import UIKit

protocol LoginInteractorProtocol {
    func goLogin(user: String?, pass: String?, navigationController: UINavigationController?)
}

final class LoginInteractor {
    var service: LoginServiceProtocol!
    var presenter: LoginPresenterProtocol?
    let misc = Misc()
    private var requestHelper = RequestHelper()
}

extension LoginInteractor: LoginInteractorProtocol {
    func goLogin(user: String?, pass: String?, navigationController: UINavigationController?) {
        presenter?.showLoading()
        let error: Error = NSError(domain: misc.localizedString(forKey: "ce_login_error"), code: 1)
        
        guard let usr = user, !usr.isEmpty else {
            presenter?.presentError(error: error)
            return
        }
        let valid = misc.emailValidation(str: usr)
        if !valid {
            presenter?.presentError(error: error)
            return
        }
        guard let pwd = pass, !pwd.isEmpty else {
            presenter?.presentError(error: error)
            return
        }
        
        service.goLogin(user: usr, pass: pwd) { querySnapshot, error in
            self.presenter?.goLogin(response: querySnapshot, error: error, navigationController: navigationController!)
        }
    }
}
