//
//  MovieDetailsPresenter.swift
//  coppelExam
//
//  Created by MacBook Air on 25/02/23.
//

import UIKit

protocol MovieDetailsPresenterProtocol {
    func showLoading()
    func hideLoading()
    func presentError(error: Error)
    func presentNextScreen(navigationController: UINavigationController, view: UIViewController)
    func showDetails(data: Data?)
    func configureView()
    func isFavouriteSaved(isSaved: Bool?)
    func isAlreadyFavourite(isFav: Bool)
}

final class MovieDetailsPresenter {
    var view: MovieDetailsViewProtocol?
    let decoder = JSONDecoder()
    let loadingView = LoadingView()
}

extension MovieDetailsPresenter: MovieDetailsPresenterProtocol {
    func isAlreadyFavourite(isFav: Bool) {
        view?.isFavourite(isFav: isFav)
    }
    
    func isFavouriteSaved(isSaved: Bool?) {
        view?.isFavouriteSaved(isSaved: isSaved)
    }
    
    func configureView() {
        view?.configureView()
    }
    
    func showDetails(data: Data?) {
        do{
            let dataStruct = try decoder.decode(MovieDetailsEntity.self, from: data!)
            view?.showDetails(movieDetails: dataStruct)
        }catch let error {
            self.presentError(error: error)
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
        self.hideLoading()
    }
    
    func presentNextScreen(navigationController: UINavigationController, view: UIViewController) {
        navigationController.pushViewController(view, animated: true)
    }
}
