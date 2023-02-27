//
//  MoviesInteractor.swift
//  coppelExam
//
//  Created by MacBook Air on 24/02/23.
//

import Foundation
import UIKit

protocol MoviesInteractorProtocol {
    func setupView()
    func getMovies(segmentedControlValue: Int)
    func presentDetailsScreen(movieId: String, navigationController: UINavigationController, segmentedControlSelection: Int)
}

final class MoviesInteractor {
    var service: MoviesServiceProtocol!
    var presenter: MoviesPresenterProtocol?
    private var requestHelper = RequestHelper()
    private let dd = DefaultData()
    private var email: String
    private var uid: String
    private var urlValue: String?
    private var createUrl: String?
    private var movieDetailsVC: UIViewController?
    private var request: URLRequest?
    
    init(email: String, uid: String){
        self.email = email
        self.uid = uid
        
        dd.persistString(key: "email", value: email)
        dd.persistString(key: "userId", value: uid)
    }
}

extension MoviesInteractor: MoviesInteractorProtocol {
    func presentDetailsScreen(movieId: String, navigationController: UINavigationController, segmentedControlSelection: Int) {
        urlValue = self.createUrl(segmentedControlSelection: segmentedControlSelection, false)
        createUrl = "\(urlValue!)\(movieId)"
        movieDetailsVC = MovieDetailsViewController().configuredView(detailsUrl: createUrl!)
        presenter?.presentNextScreen(navigationController: navigationController, view: movieDetailsVC!)
    }
    
    func getMovies(segmentedControlValue: Int = 0) {
        urlValue = self.createUrl(segmentedControlSelection: segmentedControlValue)
        
        request = requestHelper.configureGET(url: urlValue!)
        service.getMovies(request: request!) { data, error in
            self.presenter?.getMovies(data: data, error: error)
        }
    }
    
    func setupView() {
        self.getMovies()
        presenter?.setupView()
    }
    
    private func createUrl(segmentedControlSelection: Int,_ getAll: Bool = true) -> String {
        let urlValue: String = {switch segmentedControlSelection {
        case 0:
            return "/movie/\(getAll ? "popular" : "")"
        case 1:
            return "/movie/\(getAll ? "top_rated" : "")"
        case 2:
            return "/tv/\(getAll ? "on_the_air" : "")"
        case 3:
            return "/tv/\(getAll ? "airing_today" : "")"
        default:
            return "/movie/\(getAll ? "popular" : "")"
        }}()
        return urlValue
    }
}
