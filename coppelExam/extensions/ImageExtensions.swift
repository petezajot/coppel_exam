//
//  ImageExtensions.swift
//  coppelExam
//
//  Created by MacBook Air on 24/02/23.
//

import Foundation
import UIKit

extension UIImageView {
    static func background(frame: CGRect, image: String) -> UIImageView{
        let imageViewBackground = UIImageView(frame: frame)
        imageViewBackground.image = UIImage(named: image)
        imageViewBackground.layer.opacity = 0.8
        return imageViewBackground
    }
    
    static func logo(_ frame: CGRect, _ image: String) -> UIImageView{
        let logo = UIImageView(frame: frame)
        logo.layer.borderWidth = 1
        logo.layer.borderColor = UIColor.gray.cgColor
        logo.layer.cornerRadius = 10
        logo.contentMode = .scaleAspectFill
        logo.layer.opacity = 0.8
        
        let image = UIImage(named: image)
        logo.image = image
        return logo
    }
}
