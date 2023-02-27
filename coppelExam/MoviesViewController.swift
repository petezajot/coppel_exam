//
//  MoviesViewController.swift
//  coppelExam
//
//  Created by MacBook Air on 24/02/23.
//

import UIKit

protocol MoviesViewProtocol {
    func presentError(error: Error)
    func showMoviesList(data: [Results])
    func createView()
}

class MoviesViewController: UIViewController {
    var interactor: MoviesInteractorProtocol?
    private var segmentedControl: UISegmentedControl?
    private var moviesCollectionView: UICollectionView?
    private var movies: [Results] = [Results]()
    private var cellWidth: CGFloat = 175
    private var cellHeight: CGFloat = 300
    private let navBar = NavBar()
    private let misc = Misc()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
        interactor?.setupView()
    }
}

extension MoviesViewController: MoviesViewProtocol {
    func showMoviesList(data: [Results]) {
        DispatchQueue.main.async {
            self.movies = data
            self.moviesCollectionView?.reloadData()
        }
    }
    
    func presentError(error: Error) {}
    
    internal func createView() {
        view.backgroundColor = .black
        let nb = navBar.customNavBar(title: localizedString(forKey: "ce_tv_Shows"), true) {
            self.misc.showMenu(navigation: self.navigationController)
        } goBackButton: {}
        view.addSubview(nb.navBarView)
        
        segmentedControl = UISegmentedControl.custom(frame: CGRect(x: 10, y: nb.maxY + 20 , width: view.frame.width - 20, height: 30), listValues: Constants.categories)
        segmentedControl!.addTarget(self, action: #selector(getListsOfMovies), for: .valueChanged)
        view.addSubview(segmentedControl!)
        
        let columnLayout = ColumnFlowLayout(
            cellsPerRow: 2,
            minimumInteritemSpacing: 10,
            minimumLineSpacing: 10
        )
        let bottomSpace = segmentedControl!.frame.maxY + 15
        moviesCollectionView = UICollectionView(frame: CGRect(x: 5, y: segmentedControl!.frame.maxY + 10, width: view.frame.width - 10, height: view.frame.height - bottomSpace), collectionViewLayout: columnLayout)
        let nib = UINib(nibName: "MoviesCollectionViewCell", bundle: nil)
        moviesCollectionView!.backgroundColor = .black
        moviesCollectionView!.register(nib, forCellWithReuseIdentifier: "MoviesCollectionViewCell")
        moviesCollectionView!.delegate = self
        moviesCollectionView!.dataSource = self
        view.addSubview(moviesCollectionView!)
    }
    
    @objc private func getListsOfMovies() {
        interactor?.getMovies(segmentedControlValue: segmentedControl!.selectedSegmentIndex)
    }
}

extension MoviesViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = moviesCollectionView!.dequeueReusableCell(withReuseIdentifier: "MoviesCollectionViewCell", for: indexPath) as! MoviesCollectionViewCell
        cell.layer.cornerRadius = 10
        cell.results = movies[indexPath.row]
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: cellWidth, height: cellHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        interactor?.presentDetailsScreen(
            movieId: "\(movies[indexPath.row].id ?? 0)",
            navigationController: navigationController!,
            segmentedControlSelection: segmentedControl!.selectedSegmentIndex)
    }
}
