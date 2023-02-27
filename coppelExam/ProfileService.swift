//
//  ProfileService.swift
//  coppelExam
//
//  Created by MacBook Air on 26/02/23.
//

import Foundation
import FirebaseFirestore

protocol ProfileServiceProtocol {
    func getUserData(uid: String, _ output: @escaping(DocumentSnapshot?, Error?) -> Void)
    func getFavourites(_ output: @escaping([FavouritesStruct]) -> Void)
}

class ProfileService: ProfileServiceProtocol {
    private var firebaseRequest = FirebaseRequests()
    private var favsPersistance = FavouritesPersistance()
    func getUserData(uid: String, _ output: @escaping (DocumentSnapshot?, Error?) -> Void) {
        firebaseRequest.firebaseRequest(collection: "users", uid: uid) { document, error in
            output(document, error)
        }
    }
    
    func getFavourites(_ output: @escaping ([FavouritesStruct]) -> Void) {
        let favs = favsPersistance.getFavourites()
        output(favs)
    }
}

