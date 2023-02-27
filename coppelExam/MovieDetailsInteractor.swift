//
//  MovieDetailsInteractor.swift
//  coppelExam
//
//  Created by MacBook Air on 25/02/23.
//

import Foundation
import UIKit

protocol MovieDetailsInteractorProtocol {
    func setupView()
    func getDetailsData()
    func configureView()
    func saveFavourites(movieTitle: String, posterPath: String)
    func isAlreadyFavourite(movieTitle: String)
}

final class MovieDetailsInteractor {
    var service: MovieDetailsServiceProtocol!
    var presenter: MovieDetailsPresenterProtocol?
    private var requestHelper = RequestHelper()
    private var detailsUrl: String
    private var request: URLRequest?
    
    init(detailsUrl: String){
        self.detailsUrl = detailsUrl
    }
}

extension MovieDetailsInteractor: MovieDetailsInteractorProtocol {
    func isAlreadyFavourite(movieTitle: String) {
        service.isAlreadyFavourite(movieTitle: movieTitle) { isFav in
            self.presenter?.isAlreadyFavourite(isFav: isFav)
        }
    }
    
    func saveFavourites(movieTitle: String, posterPath: String) {
        service.saveFavourites(movieTitle: movieTitle, posterPath: posterPath) { isSaved in
            self.presenter?.isFavouriteSaved(isSaved: isSaved)
        }
    }
    
    func getDetailsData() {
        request = requestHelper.configureGET(url: self.detailsUrl)
        service.getDetailsData(request: request!) { data, error in
            if let err = error {
                self.presenter?.presentError(error: err)
            }
            self.presenter?.showDetails(data: data)
        }
    }
    
    func setupView() {
        self.getDetailsData()
    }
    
    func configureView() {
        presenter?.configureView()
    }
}
