//
//  Constants.swift
//  coppelExam
//
//  Created by MacBook Air on 24/02/23.
//

import Foundation
import UIKit

struct Constants {
    static var url: String = "https://api.themoviedb.org/3"
    static var apiKey: String = "db84af1f9c34115cfdb9d7a27532e6a8"
    static let width = UIScreen.main.bounds.size.width
    static let height = UIScreen.main.bounds.size.height
    static let imageUrl: String = "http://image.tmdb.org/t/p/w500"
    static let categories: [String] = [
        Misc().localizedString(forKey: "ce_popular"),
        Misc().localizedString(forKey: "ce_top_rated"),
        Misc().localizedString(forKey: "ce_on_tv"),
        Misc().localizedString(forKey: "ce_airing_today")
    ]
}
