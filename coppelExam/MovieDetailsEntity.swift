//
//  MovieDetailsEntity.swift
//  coppelExam
//
//  Created by MacBook Air on 25/02/23.
//

import Foundation
import RealmSwift

struct MovieDetailsEntity: Codable {
    var overview: String?
    var poster_path: String?
    var release_date: String?
    var title: String?
    var name: String?
    var vote_average: Double?
    var production_companies: [ProductionCompanies]?
    var genres: [Genres]?
}

struct ProductionCompanies: Codable {
    var logo_path: String?
    var name: String?
}

struct Genres: Codable {
    var id: Int?
    var name: String?
}

class Favourites: Object {
    @Persisted(primaryKey: true) var movieTitle = String()
    @Persisted var posterPath = String()
}

struct FavouritesStruct: Codable {
    var movieTitle: String?
    var posterPath: String?
}
