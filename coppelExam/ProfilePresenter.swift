//
//  ProfilePresenter.swift
//  coppelExam
//
//  Created by MacBook Air on 26/02/23.
//

import UIKit
import FirebaseFirestore

protocol ProfilePresenterProtocol {
    func showLoading()
    func hideLoading()
    func presentError(error: Error)
    func presentNextScreen(navigationController: UINavigationController, view: UIViewController)
    func setupView()
    func setUserData(document: DocumentSnapshot?, error: Error?)
    func getFavourites(favs: [FavouritesStruct])
}

final class ProfilePresenter {
    var view: ProfileViewProtocol?
    let decoder = JSONDecoder()
    private let loadingView = LoadingView()
    private var profileEntity = ProfileEntity()
    private var dataDescription: [String : Any]?
}

extension ProfilePresenter: ProfilePresenterProtocol {
    func getFavourites(favs: [FavouritesStruct]) {
        view?.getFavourites(favs: favs)
    }
    
    func setUserData(document: DocumentSnapshot?, error: Error?) {
        dataDescription = document?.data()
        profileEntity.email = dataDescription!["email"] as? String
        profileEntity.name = dataDescription!["name"] as? String
        profileEntity.lastName = dataDescription!["lastName"] as? String
        view?.setUserData(userData: profileEntity)
    }
    
    func setupView() {
        view?.setupView()
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
