//
//  MoviesEntity.swift
//  coppelExam
//
//  Created by MacBook Air on 24/02/23.
//

import Foundation

struct MoviesEntity: Codable {
    var results: [Results]?
}

struct Results: Codable {
    var title: String?
    var release_date: String?
    var vote_average: Double?
    var overview: String?
    var poster_path: String?
    var id: Int?
    var original_name: String?
    var first_air_date: String?
    var name: String?
}
