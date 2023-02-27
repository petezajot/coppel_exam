//
//  LoginViewController.swift
//  coppelExam
//
//  Created by MacBook Air on 24/02/23.
//

import UIKit

protocol LoginViewProtocol {
    func presentError(error: Error)
}

class LoginViewController: UIViewController, UITextFieldDelegate{
    var interactor: LoginInteractorProtocol?
    private var userField, passField: UITextField?
    private var logo: UIImageView?
    private var button: UIButton?
    private var errorLabel: UILabel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createView()
    }
    
    private func createView() {
        view.backgroundColor = .black
        
        logo = UIImageView.logo(CGRect(x: 50, y: 150, width: view.frame.width - 300, height: 100), "logo2")
        view.addSubview(logo!)
        
        userField = UITextField.custom(frame: CGRect(x: 15, y: logo!.frame.maxY + 120, width: view.frame.width - 30, height: 40), keyboard: .emailAddress, hint: localizedString(forKey: "ce_user"), retKey: .next, secureText: false, id: "userField", size: 40)
        
        view.addSubview(userField!)
        
        passField = UITextField.custom(frame: CGRect(x: 15, y: userField!.frame.maxY + 30, width: view.frame.width - 30, height: 40), keyboard: .default, hint: localizedString(forKey: "ce_pass"), retKey: .done, secureText: true, id: "passField", size: 40)
        
        view.addSubview(passField!)
        
        button = UIButton.custom(frame: CGRect(x: 15, y: passField!.frame.maxY + 50, width: view.frame.width - 30, height: 50), title: localizedString(forKey: "ce_login_btn"))
        button?.addTarget(self, action: #selector(goLogin), for: .touchUpInside)
        view.addSubview(button!)
    }
    
    @objc private func goLogin() {
        if let _ = errorLabel {
            errorLabel!.removeFromSuperview()
        }
        let user: String = userField!.text ?? String()
        let pass: String = passField!.text ?? String()
        interactor?.goLogin(user: user, pass: pass, navigationController: navigationController)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if userField!.isFirstResponder {
            passField!.becomeFirstResponder()
        }else if passField!.isFirstResponder {
            passField!.resignFirstResponder()
        }
        return true
    }
}

extension LoginViewController: LoginViewProtocol {
    func presentError(error: Error) {
        errorLabel = UILabel.errorLabel(frame: CGRect(x: 5, y: button!.frame.maxY + 10, width: view.frame.width - 10, height: 50), text: error.errorDomain ?? String())
        errorLabel!.isHidden = false
        view.addSubview(errorLabel!)
    }
}
