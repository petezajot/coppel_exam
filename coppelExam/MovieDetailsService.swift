//
//  MovieDetailsService.swift
//  coppelExam
//
//  Created by MacBook Air on 25/02/23.
//

import Foundation

protocol MovieDetailsServiceProtocol {
    func getDetailsData(request: URLRequest, _ output: @escaping(Data?, Error?) -> Void)
    func saveFavourites(movieTitle: String, posterPath: String, _ output: @escaping(Bool?) -> Void)
    func isAlreadyFavourite(movieTitle: String, _ output: @escaping(Bool) -> Void)
}

class MovieDetailsService: MovieDetailsServiceProtocol {
    private var networkRequest = APIRequests()
    private let favs = FavouritesPersistance()
    
    func getDetailsData(request: URLRequest, _ output: @escaping (Data?, Error?) -> Void) {
        networkRequest.networkRequest(request: request) { data, error in
            output(data, error)
        }
    }
    
    func saveFavourites(movieTitle: String, posterPath: String, _ output: @escaping (Bool?) -> Void) {
        favs.saveFavourites(movieTitle: movieTitle, posterPath: posterPath) { isSaved in
            output(isSaved)
        }
    }
    
    func isAlreadyFavourite(movieTitle: String, _ output: @escaping(Bool) -> Void) {
        let isFav = favs.isAlreadyFavourite(movieTitle: movieTitle)
        output(isFav)
    }
}

