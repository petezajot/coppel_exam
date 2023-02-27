//
//  UIViewControllerExtensions.swift
//  coppelExam
//
//  Created by MacBook Air on 27/02/23.
//

import Foundation
import UIKit

extension UIViewController {
    func localizedString(forKey key: String) -> String {
        var result = Bundle.main.localizedString(forKey: key, value: nil, table: nil)
        if result == key {
            result = Bundle.main.localizedString(forKey: key, value: nil, table: "Default")
        }
        
        return result
    }
}
