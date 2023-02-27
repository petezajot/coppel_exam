//
//  NavBar.swift
//  coppelExam
//
//  Created by MacBook Air on 24/02/23.
//

import Foundation
import UIKit

class NavBar: UIViewController {
    private var menu: (() -> Void)?
    private var goBack: (() -> Void)?
    
    func customNavBar(
        title: String,
        _ hideBackButton: Bool = false,
        _ hideMenuButton: Bool = false,
        menuClosure: @escaping () -> (),
        goBackButton: @escaping () -> ()
    ) -> (navBarView: UIView, maxY: CGFloat) {
        let hasNotch = UIDevice.current.hasNotch
        let topHeight: CGFloat = hasNotch ? 100 : 65
        menu = menuClosure
        goBack = goBackButton

        let navBar = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: topHeight))
        navBar.backgroundColor = .darkGray
        
        let backButton = UIButton(frame: CGRect(x: navBar.frame.minX + 20, y: navBar.frame.maxY - 30, width: 20, height: 20))
        backButton.setImage(UIImage(named: "backArrow"), for: .normal)
        backButton.addTarget(self, action: #selector(dismissCurrentView), for: .touchUpInside)
        backButton.isHidden = hideBackButton
        navBar.addSubview(backButton)
        
        let titleLabel = UILabel(frame: CGRect(x: backButton.frame.maxX, y: navBar.frame.maxY - 30, width: view.frame.width - 90, height: 25))
        titleLabel.text = title
        titleLabel.textColor = .white
        titleLabel.textAlignment = .center
        navBar.addSubview(titleLabel)
        
        let menuButton = UIButton(frame: CGRect(x: navBar.frame.maxX - 40, y: navBar.frame.maxY - 30, width: 20, height: 20))
        menuButton.setImage(UIImage(named: "topmenu"), for: .normal)
        menuButton.addTarget(self, action: #selector(commonFunction), for: .touchUpInside)
        menuButton.isHidden = hideMenuButton
        navBar.addSubview(menuButton)
        
        
        return (navBar, navBar.frame.maxY)
    }
    
    @objc func commonFunction() {
        menu!()
    }
    
    @objc func dismissCurrentView() {
        goBack!()
    }
}
