//
//  ProfileViewController.swift
//  coppelExam
//
//  Created by MacBook Air on 26/02/23.
//

import UIKit

protocol ProfileViewProtocol {
    func presentError(error: Error)
    func setupView()
    func setUserData(userData: ProfileEntity)
    func getFavourites(favs: [FavouritesStruct])
}

class ProfileViewController: UIViewController {
    var interactor: ProfileInteractorProtocol?
    private var titleLabel, userLabel, favouritesLabel, userName: UILabel?
    private var closeButton: UIButton?
    private var avatar, poster: UIImageView?
    private var userData: ProfileEntity = ProfileEntity()
    private var userFavs: [FavouritesStruct] = [FavouritesStruct]()
    private var favsContainer: UIView?
    private var rect: CGRect?
    private var scrollView: UIScrollView?
    private var misc: Misc = Misc()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        interactor?.getUserData()
    }
}

extension ProfileViewController: ProfileViewProtocol {
    func setUserData(userData: ProfileEntity) {
        self.userData = userData
        interactor?.getFavourites()
    }
    
    func getFavourites(favs: [FavouritesStruct]) {
        self.userFavs = favs
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) { self.interactor?.setupView() }
    }
    
    func setupView() {
        view.backgroundColor = .black
        titleLabel = UILabel.commonLabel(x: 20, y: 30, width: view.frame.width - 40, text: localizedString(forKey: "ce_profile"))
        view.addSubview(titleLabel!)
        
        closeButton = UIButton.closeButton(x: view.frame.maxX - 50, y: 30)
        view.addSubview(closeButton!)
        closeButton!.addTarget(self, action: #selector(dismissProfile), for: .touchUpInside)
        
        avatar = UIImageView(frame: CGRect(x: 25, y: titleLabel!.frame.maxY + 30, width: 120, height: 120))
        avatar!.image = UIImage(named: "avatar")
        view.addSubview(avatar!)
        
        userName = UILabel.commonLabel(x: avatar!.frame.maxX + 10, y: avatar!.frame.midY - 30, width: view.frame.width - 140, text: "\(userData.name ?? String()) \(userData.lastName ?? String())")
        view.addSubview(userName!)
        
        userLabel = UILabel.commonLabel(x: avatar!.frame.maxX + 10, y: userName!.frame.maxY, width: view.frame.width - 140, text: userData.email ?? String())
        view.addSubview(userLabel!)

        if userFavs.count > 0 {
            scrollView = UIScrollView.horizontalScrollView(frame: CGRect(x: 0, y: view.frame.maxY - 360, width: view.frame.width, height: 350))
            for favs in userFavs {
                if rect == nil {
                    rect = CGRect(x: 0, y: 0, width: view.frame.width - 150, height: 330)
                }else{
                    rect = CGRect(x: rect!.maxX, y: 0, width: view.frame.width - 150, height: 330)
                }
                favsContainer = UIView.favouritesCards(
                    frame: rect!,
                    imageUrl: favs.posterPath ?? String(),
                    text: favs.movieTitle ?? String())
                scrollView!.addSubview(favsContainer!)                
            }
            scrollView!.contentSize = CGSize(width: rect!.maxX, height: view.frame.height - 50)
            scrollView!.contentSize.height = 1.0
            view.addSubview(scrollView!)
            
            favouritesLabel = UILabel.commonLabel(x: 20, y: scrollView!.frame.minY - 30, width: view.frame.width - 40, text: localizedString(forKey: "ce_favs_show"))
            view.addSubview(favouritesLabel!)
        }
    }
    
    @objc private func dismissProfile() {
        self.dismiss(animated: true)
    }
    
    func presentError(error: Error) {}
}
