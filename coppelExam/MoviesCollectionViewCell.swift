//
//  MoviesCollectionViewCell.swift
//  coppelExam
//
//  Created by MacBook Air on 24/02/23.
//

import UIKit

class MoviesCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var topImage: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var releaseDate: UILabel!
    @IBOutlet weak var voteAverage: UILabel!
    @IBOutlet weak var overview: UILabel!
    private let misc: Misc = Misc()
    
    var results: Results? {
        didSet {
            self.title.text = results?.title != nil ? results?.title : results?.name
            self.releaseDate.text = results?.release_date != nil ? results?.release_date : results?.first_air_date
            self.voteAverage.text = "⭐️ \(self.results?.vote_average ?? Double())"
            self.overview.text = results?.overview
            
            misc.detailsPoster(url: results?.poster_path ?? String()) { image in
                self.topImage.image = image
            }
        }
    }
    
}
