//
//  MovieDetailsConfigurator.swift
//  coppelExam
//
//  Created by MacBook Air on 25/02/23.
//

import UIKit

extension MovieDetailsViewController {
    func configuredView(detailsUrl: String) -> UIViewController {
        let view = self
        
        let interactor = MovieDetailsInteractor(detailsUrl: detailsUrl)
        let presenter = MovieDetailsPresenter()
        let service = MovieDetailsService()
        
        view.interactor = interactor
        interactor.presenter = presenter
        interactor.service = service
        presenter.view = view
        
        return view
    }
}
