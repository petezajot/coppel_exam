//
//  LoadingView.swift
//  coppelExam
//
//  Created by MacBook Air on 24/02/23.
//

import Foundation
import UIKit

class LoadingView: UIViewController {
    private let alert = UIAlertController(title: nil, message: Misc().localizedString(forKey: "ce_please_wait"), preferredStyle: .alert)
    func createLoader() {
        let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 5, y: 5, width: 50, height: 50))
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.startAnimating()
        alert.view.addSubview(loadingIndicator)
        
        let keyWindow = UIApplication.shared.windows.filter {$0.isKeyWindow}.first
        if var topController = keyWindow?.rootViewController {
            while let presentedViewController = topController.presentedViewController {
                topController = presentedViewController
            }
            topController.present(alert, animated: true)
        }
        
    }
    
    func dismissLoader(){
        alert.dismiss(animated: true)
    }
}
