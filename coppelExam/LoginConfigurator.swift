//
//  LoginConfigurator.swift
//  coppelExam
//
//  Created by MacBook Air on 24/02/23.
//

import UIKit

extension LoginViewController {
    func configuredView() -> UIViewController {
        let view = self
        
        let interactor = LoginInteractor()
        let presenter = LoginPresenter()
        let service = LoginService()
        
        view.interactor = interactor
        interactor.presenter = presenter
        interactor.service = service
        presenter.view = view
        
        return view
    }
}
