//
//  UILabelExtensions.swift
//  coppelExam
//
//  Created by MacBook Air on 24/02/23.
//

import Foundation
import UIKit

extension UILabel {
    static func errorLabel(frame: CGRect, text: String) -> UILabel {
        let label = UILabel(frame: frame)
        label.textColor = .red
        label.textAlignment = .center
        label.numberOfLines = 0
        label.font = label.font.withSize(12)
        label.text = text
        return label
    }
    
    static func commonLabel(x: CGFloat, y: CGFloat, width: CGFloat, text: String) -> UILabel {
        let label = UILabel(frame: CGRect(x: x, y: y, width: width, height: 40))
        label.text = text
        label.textColor = .white
        label.font = UIFont(name:"HelveticaNeue-Bold", size: 18.0)
        label.font = UIFont.boldSystemFont(ofSize: 16.0)
        return label
    }
}
