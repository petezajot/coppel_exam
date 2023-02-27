//
//  MoviesConfigurator.swift
//  coppelExam
//
//  Created by MacBook Air on 24/02/23.
//

import UIKit

extension MoviesViewController {
    func configuredView(email: String, uid: String) -> UIViewController {
        let view = self
        
        let interactor = MoviesInteractor(email: email, uid: uid)
        let presenter = MoviesPresenter()
        let service = MoviesService()
        
        view.interactor = interactor
        interactor.presenter = presenter
        interactor.service = service
        presenter.view = view
        
        return view
    }
}
