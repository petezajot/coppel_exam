//
//  ProfileConfigurator.swift
//  coppelExam
//
//  Created by MacBook Air on 26/02/23.
//

import UIKit

extension ProfileViewController {
    func configuredView() -> UIViewController {
        let view = self
        
        let interactor = ProfileInteractor()
        let presenter = ProfilePresenter()
        let service = ProfileService()
        
        view.interactor = interactor
        interactor.presenter = presenter
        interactor.service = service
        presenter.view = view
        
        return view
    }
}
