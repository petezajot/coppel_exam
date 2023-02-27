//
//  UIButtonExtensions.swift
//  coppelExam
//
//  Created by MacBook Air on 24/02/23.
//

import Foundation
import UIKit

extension UIButton {
    static func custom(frame: CGRect, title: String) -> UIButton{
        let btn = UIButton(frame: frame)
        btn.backgroundColor = .black
        btn.setTitle(title, for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.layer.borderWidth = 1
        btn.layer.borderColor = UIColor.gray.cgColor
        btn.layer.cornerRadius = 25
        btn.layer.shadowColor = UIColor.gray.cgColor
        btn.layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
        btn.layer.shadowRadius = 25
        btn.layer.shadowOpacity = 0.8
        btn.showsTouchWhenHighlighted = true
        
        return btn
    }
    
    static func closeButton(x: CGFloat, y: CGFloat) -> UIButton {
        let button = UIButton(frame: CGRect(x: x, y: y, width: 40, height: 40))
        button.setImage(UIImage(named: "closeIcon"), for: .normal)
        return button
    }
}
