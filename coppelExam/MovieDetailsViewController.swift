//
//  MovieDetailsViewController.swift
//  coppelExam
//
//  Created by MacBook Air on 25/02/23.
//

import UIKit

protocol MovieDetailsViewProtocol {
    func presentError(error: Error)
    func showDetails(movieDetails: MovieDetailsEntity)
    func configureView()
    func isFavouriteSaved(isSaved: Bool?)
    func isFavourite(isFav: Bool)
}

class MovieDetailsViewController: UIViewController {
    var interactor: MovieDetailsInteractorProtocol?
    private var scrollView: UIScrollView?
    private var posterPath, producersLogo: UIImageView?
    private var labelTitle, dateLabel, voteLabel, overviewTitle, overviewLabel, genresTitle, genresLabel, productionCompaniesTitle: UILabel?
    private var favouriteStarButton: UIButton?
    private var movieDetails: MovieDetailsEntity = MovieDetailsEntity()
    private var star: String = "⭐️"
    private var misc: Misc = Misc()
    private let navBar = NavBar()
    private var customToast = CustomToast()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
        interactor?.setupView()
    }
}

extension MovieDetailsViewController: MovieDetailsViewProtocol {
    func isFavourite(isFav: Bool) {
        star = isFav ? localizedString(forKey: "ce_star_fav") : localizedString(forKey: "ce_star")
    }
    
    func isFavouriteSaved(isSaved: Bool?) {
        customToast.showToast(text: isSaved! ? localizedString(forKey: "ce_favourite_saved"): localizedString(forKey: "ce_favourite_existent"))
    }
    
    
    func showDetails(movieDetails: MovieDetailsEntity) {
        self.movieDetails = movieDetails
        DispatchQueue.main.async {
            self.interactor?.isAlreadyFavourite(movieTitle: self.movieDetails.title ?? self.movieDetails.name ?? String())
            self.interactor?.configureView()
        }
    }
    
    func configureView() {
        let nb = navBar.customNavBar(title: localizedString(forKey: "ce_tv_Shows"), false, true) {
        } goBackButton: {
            self.navigationController?.popViewController(animated: true)
        }
        view.addSubview(nb.navBarView)
        view.addSubview(nb.navBarView)
        view.bringSubviewToFront(nb.navBarView)
        
        favouriteStarButton = UIButton(frame: CGRect(x: view.frame.maxX - 50, y: nb.maxY + 30, width: 35, height: 35))
        favouriteStarButton!.setTitle(star, for: .normal)
        view.addSubview(favouriteStarButton!)
        favouriteStarButton!.addTarget(self, action: #selector(addTapped), for: .touchUpInside)
        
        posterPath = UIImageView(frame: CGRect(x: 0, y: nb.maxY + 20, width: view.frame.width, height: 250))
        misc.detailsPoster(url: self.movieDetails.poster_path, imageOutput: { image in
            self.posterPath!.image = image
        })
        posterPath!.contentMode = .scaleAspectFit
        view.addSubview(posterPath!)
        
        scrollView = UIScrollView(frame: CGRect(x: 0, y: posterPath!.frame.maxY, width: view.frame.width, height: view.frame.height))
        scrollView!.translatesAutoresizingMaskIntoConstraints = false
        scrollView!.contentSize = CGSize(width: self.view.bounds.width, height: self.view.bounds.height + 200)
        
        view.addSubview(scrollView!)
        
        labelTitle = UILabel.commonLabel(
            x: 5,
            y: 10,
            width: view.frame.width - 10,
            text: self.movieDetails.title ?? String())
        scrollView!.addSubview(labelTitle!)
        
        dateLabel = UILabel.commonLabel(
            x: 5,
            y: labelTitle!.frame.maxY + 10,
            width: Constants.width / 2,
            text: self.movieDetails.release_date ?? String())
        scrollView!.addSubview(dateLabel!)
        
        voteLabel = UILabel.commonLabel(
            x: dateLabel!.frame.maxX,
            y: labelTitle!.frame.maxY + 10,
            width: Constants.width / 2 - 10,
            text: "⭐️ \(self.movieDetails.vote_average ?? Double())")
        voteLabel!.textAlignment = .right
        scrollView!.addSubview(voteLabel!)
        
        scrollView!.addSubview(misc.divider(y: dateLabel!.frame.maxY + 5, view: view))
        
        overviewTitle = UILabel.commonLabel(
            x: 10,
            y: dateLabel!.frame.maxY + 10,
            width: view.frame.width - 20,
            text: localizedString(forKey: "ce_overview_title"))
        scrollView!.addSubview(overviewTitle!)
        
        overviewLabel = UILabel.commonLabel(x: 10, y: overviewTitle!.frame.maxY + 25, width: view.frame.width - 20, text: self.movieDetails.overview ?? String())
        scrollView!.addSubview(overviewLabel!)
        overviewLabel!.numberOfLines = 0
        overviewLabel!.sizeToFit()
        
        scrollView!.addSubview(misc.divider(y: overviewLabel!.frame.maxY + 5, view: view))
        
        genresTitle = UILabel.commonLabel(x: 10, y: overviewLabel!.frame.maxY + 10, width: view.frame.width - 20, text: localizedString(forKey: "ce_genres"))
        scrollView!.addSubview(genresTitle!)
        
        genresLabel = UILabel.commonLabel(
            x: 10,
            y: genresTitle!.frame.maxY,
            width: view.frame.width - 20,
            text: misc.genresStringified(genres: self.movieDetails.genres ?? [Genres]()))
        scrollView!.addSubview(genresLabel!)
        genresLabel!.numberOfLines = 0
        genresLabel!.sizeToFit()
        
        scrollView!.addSubview(misc.divider(y: genresLabel!.frame.maxY + 5, view: view))
        
        productionCompaniesTitle = UILabel.commonLabel(x: 10, y: genresLabel!.frame.maxY + 10, width: view.frame.width - 20, text: localizedString(forKey: "ce_prod_companies"))
        scrollView!.addSubview(productionCompaniesTitle!)
        
        producersLogo = UIImageView(frame: CGRect(x: 20, y: productionCompaniesTitle!.frame.maxY + 10, width: view.frame.width - 40, height: 100))
        let logo = self.movieDetails.production_companies?.count ?? 0 > 0 ? self.movieDetails.production_companies?[0].logo_path : String()
        misc.detailsPoster(url: logo, imageOutput: { image in
            self.producersLogo!.image = image
        })
        producersLogo!.contentMode = .scaleAspectFit
        producersLogo!.backgroundColor = .white
        scrollView!.addSubview(producersLogo!)
    }
    
    @objc private func addTapped(){
        star = "🌟"
        favouriteStarButton!.setTitle(star, for: .normal)
        interactor?.saveFavourites(
            movieTitle: self.movieDetails.title ?? self.movieDetails.name ?? String(),
            posterPath: self.movieDetails.poster_path ?? String()
        )
    }
    
    func presentError(error: Error) {}
}
