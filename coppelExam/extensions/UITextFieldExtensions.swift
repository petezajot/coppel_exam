//
//  UITextFieldExtensions.swift
//  coppelExam
//
//  Created by MacBook Air on 24/02/23.
//

import Foundation
import UIKit

extension UITextField {
    static func custom(frame: CGRect, keyboard: UIKeyboardType, hint: String, retKey: UIReturnKeyType, secureText: Bool, id: String, size: CGFloat) -> UITextField {
        let field = UITextField(frame: frame)
        field.autocapitalizationType = .none
        field.keyboardType = keyboard
        field.attributedPlaceholder = NSAttributedString(string: hint, attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray])
        field.returnKeyType = retKey
        field.isSecureTextEntry = secureText
        field.textColor = .white
        field.clearButtonMode = .whileEditing
        field.accessibilityIdentifier = id
        field.leftViewMode = .always
        field.backgroundColor = .black
        field.layer.opacity = 0.95
        field.layer.cornerRadius = 10
        field.layer.borderWidth = 1.5
        field.layer.borderColor = UIColor.gray.cgColor
        field.font = UIFont(name: "Tilt-Wrap", size: 15)
        
        let paddingView: UIView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: 20))
        field.leftView = paddingView
        field.leftViewMode = .always
        
        return field
    }
}
