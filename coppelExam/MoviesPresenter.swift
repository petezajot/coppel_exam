//
//  MoviesPresenter.swift
//  coppelExam
//
//  Created by MacBook Air on 24/02/23.
//

import UIKit

protocol MoviesPresenterProtocol {
    func showLoading()
    func hideLoading()
    func presentError(error: Error)
    func presentNextScreen(navigationController: UINavigationController, view: UIViewController)
    func getMovies(data: Data?, error: Error?)
    func setupView()
}

final class MoviesPresenter {
    var view: MoviesViewProtocol?
    let decoder = JSONDecoder()
    let loadingView = LoadingView()
}

extension MoviesPresenter: MoviesPresenterProtocol {
    func setupView() {
        view?.createView()
    }
    
    func getMovies(data: Data?, error: Error?) {
        if let err = error {
            presentError(error: err)
        }else{
            do{
                let data = try decoder.decode(MoviesEntity.self, from: data!)
                view?.showMoviesList(data: data.results!)
            }catch let error {
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
        self.hideLoading()
    }
    
    func presentNextScreen(navigationController: UINavigationController, view: UIViewController) {
        navigationController.pushViewController(view, animated: true)
    }
}
