//
//  APIRequests.swift
//  coppelExam
//
//  Created by MacBook Air on 24/02/23.
//

import Foundation

class APIRequests {
    let session = URLSession(configuration: .default)
    var dataTask: URLSessionDataTask? = nil
    
    func networkRequest(request: URLRequest, _ output: @escaping(Data?, Error?) -> Void) {
        dataTask = session.dataTask(with: request) { data, response, error in
            output(data, error)
        }
        dataTask!.resume()
    }
}
