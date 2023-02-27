//
//  CustomToast.swift
//  coppelExam
//
//  Created by MacBook Air on 27/02/23.
//

import Foundation
import UIKit

class CustomToast: UIViewController {
    func showToast(text: String) {
        let toast = UIAlertController(title: nil, message: text, preferredStyle: .alert)
        
        let keyWindow = UIApplication.shared.windows.filter {$0.isKeyWindow}.first
        if var topController = keyWindow?.rootViewController {
            while let presentedViewController = topController.presentedViewController {
                topController = presentedViewController
            }
            topController.present(toast, animated: true)
        }
        
        let when = DispatchTime.now() + 2.5
        DispatchQueue.main.asyncAfter(deadline: when){
            toast.dismiss(animated: true, completion: nil)
        }
        
    }
}
