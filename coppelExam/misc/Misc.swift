//
//  Misc.swift
//  coppelExam
//
//  Created by MacBook Air on 24/02/23.
//

import Foundation
import UIKit

class Misc {
    func emailValidation(str: String) -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format: "SELF Matches %@", emailRegex)
        return emailPred.evaluate(with: str)
    }
    
    func detailsPoster(url: String?, imageOutput: @escaping(UIImage) -> Void) {
        let urlString: String = "\(Constants.imageUrl)\(url ?? String())"
        if let url = URL(string: urlString) {
            let task = URLSession.shared.dataTask(with: url) { data, response, error in
                guard let data = data, error == nil else { return }
                DispatchQueue.main.async {
                    imageOutput((UIImage(data: data) ?? UIImage(named: "placeholder")!))
                }
            }
            task.resume()
        }
    }
    
    func divider(y: CGFloat, view: UIView) -> UIView {
        let divider = UIView(frame: CGRect(x: 5, y: y, width: view.frame.width - 10, height: 1))
        divider.backgroundColor = .darkGray
        return divider
    }
    
    func genresStringified(genres: [Genres]) -> String {
        var value: String = String()
        var count: Int = 1
        genres.forEach { i in
            if count < genres.count {
                value += "\(i.name!), "
            }else{
                value += "\(i.name!)"
            }
            count += 1
        }
        return value
    }
    
    func producersStringified(producers: [ProductionCompanies]) -> String {
        var value: String = ""
        var count: Int = 1
        producers.forEach { i in
            if count < producers.count {
                value += "\(i.name!), "
            }else{
                value += "\(i.name!)"
            }
            count += 1
        }
        return value
    }
    
    func showMenu(navigation: UINavigationController?) {
        let alert = UIAlertController(title: "", message: Misc().localizedString(forKey: "ce_menu_title"), preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: Misc().localizedString(forKey: "ce_menu_profile"), style: .default , handler:{ (UIAlertAction)in
            let profileView = ProfileViewController().configuredView()
            navigation!.present(profileView, animated: true)
        }))
        alert.addAction(UIAlertAction(title: Misc().localizedString(forKey: "ce_menu_log_out"), style: .destructive , handler:{ (UIAlertAction)in
            navigation?.popViewController(animated: true)
        }))
        alert.addAction(UIAlertAction(title: Misc().localizedString(forKey: "ce_menu_cancel"), style: .cancel, handler:{ (UIAlertAction)in
            
        }))
        
        let keyWindow = UIApplication.shared.windows.filter {$0.isKeyWindow}.first
        if var topController = keyWindow?.rootViewController {
            while let presentedViewController = topController.presentedViewController {
                topController = presentedViewController
            }
            topController.present(alert, animated: true)
        }
    }
    
    func localizedString(forKey key: String) -> String {
        var result = Bundle.main.localizedString(forKey: key, value: nil, table: nil)
        if result == key {
            result = Bundle.main.localizedString(forKey: key, value: nil, table: "Default")
        }
        
        return result
    }
}
