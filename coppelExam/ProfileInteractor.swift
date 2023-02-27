//
//  ProfileInteractor.swift
//  coppelExam
//
//  Created by MacBook Air on 26/02/23.
//

import Foundation
import UIKit

protocol ProfileInteractorProtocol {
    func setupView()
    func getUserData()
    func getFavourites()
}

final class ProfileInteractor {
    var service: ProfileServiceProtocol!
    var presenter: ProfilePresenterProtocol?
    private var requestHelper = RequestHelper()
    private var defaultData = DefaultData()
}

extension ProfileInteractor: ProfileInteractorProtocol {
    func getFavourites() {
        self.service.getFavourites { favs in
            self.presenter?.getFavourites(favs: favs)
        }
    }
    
    func getUserData() {
        let uid = defaultData.getString(key: "userId")
        service.getUserData(uid: uid) { document, error in
            self.presenter?.setUserData(document: document, error: error)
        }
    }
    
    func setupView() {
        presenter?.setupView()
    }
}
