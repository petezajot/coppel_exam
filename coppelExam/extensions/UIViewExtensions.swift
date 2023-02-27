//
//  UIViewExtensions.swift
//  coppelExam
//
//  Created by MacBook Air on 27/02/23.
//

import Foundation
import UIKit

extension UIView {
    static func favouritesCards(frame: CGRect, imageUrl: String, text: String) -> UIView {
        let misc = Misc()
        let container = UIView(frame: frame)
        container.backgroundColor = .darkGray
        container.layer.borderWidth = 15
        container.layer.borderColor = UIColor.black.cgColor
        container.layer.cornerRadius = 25
        
        let poster = UIImageView(frame: CGRect(x: 40, y: 20, width: container.frame.width - 80, height: 250))
        misc.detailsPoster(url: imageUrl) { image in
            poster.image = image
        }
        container.addSubview(poster)
        
        let label = UILabel.commonLabel(x: 20, y: poster.frame.maxY + 10, width: container.frame.width - 40, text: text)
        container.addSubview(label)
        
        return container
    }
}
