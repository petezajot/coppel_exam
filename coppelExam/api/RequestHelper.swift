//
//  RequestHelper.swift
//  coppelExam
//
//  Created by MacBook Air on 24/02/23.
//

import Foundation

class RequestHelper {
    func configureGET(url: String) -> URLRequest {
        let createUrl = "\(Constants.url)\(url)?api_key=\(Constants.apiKey)&language=en-US"
        let urlString = createUrl.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        var request: URLRequest = URLRequest(url: URL(string: urlString!)!, timeoutInterval: Double.infinity)
        request.addValue("application/json", forHTTPHeaderField: "ContentType")
        request.httpMethod = "GET"
        return request
    }
}
