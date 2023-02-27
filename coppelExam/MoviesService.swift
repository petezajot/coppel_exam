//
//  MoviesService.swift
//  coppelExam
//
//  Created by MacBook Air on 24/02/23.
//

import Foundation

protocol MoviesServiceProtocol {
    func getMovies(request: URLRequest, _ output: @escaping(Data?, Error?) -> Void)
}

class MoviesService: MoviesServiceProtocol {
    private var networkRequest = APIRequests()
    
    func getMovies(request: URLRequest, _ output: @escaping (Data?, Error?) -> Void) {
        networkRequest.networkRequest(request: request) { data, error in
            output(data, error)
        }
    }
}

