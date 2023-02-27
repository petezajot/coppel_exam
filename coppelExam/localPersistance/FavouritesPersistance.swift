//
//  FavouritesPersistance.swift
//  coppelExam
//
//  Created by MacBook Air on 26/02/23.
//

import Foundation
import RealmSwift

class FavouritesPersistance {
    private let realm = try! Realm()
    private let favs = Favourites()
    private var favStruct: FavouritesStruct = FavouritesStruct()
    
    func saveFavourites(
        movieTitle: String,
        posterPath: String,
        registered: @escaping(Bool?) -> Void
    ) {
        
        let existingMovie = realm.object(ofType: Favourites.self, forPrimaryKey: movieTitle)
        if let _ = existingMovie {
            registered(false)
        }else{
            do{
                try realm.write {
                    favs.movieTitle = movieTitle
                    favs.posterPath = posterPath
                    realm.add(favs)
                    registered(true)
                }
            }catch let error as NSError {
                print("Error: \(error.localizedDescription)")
            }
        }
    }
    
    func isAlreadyFavourite(movieTitle: String) -> Bool {
        let isFavouriteMovie = realm.object(ofType: Favourites.self, forPrimaryKey: movieTitle)
        var bool = false
        if let _ = isFavouriteMovie { bool = true }else{ bool = false }
        return bool
    }
    
    func getFavourites() -> [FavouritesStruct] {
        let favs = realm.objects(Favourites.self)
        var arrayFavs = [FavouritesStruct]()
        favs.forEach { Favourites in
            self.favStruct.movieTitle = Favourites.movieTitle
            self.favStruct.posterPath = Favourites.posterPath
            arrayFavs.append(self.favStruct)
        }
        return arrayFavs
    }
}
