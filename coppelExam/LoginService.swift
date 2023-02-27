//
//  LoginService.swift
//  coppelExam
//
//  Created by MacBook Air on 24/02/23.
//

import Foundation
import FirebaseAuth

protocol LoginServiceProtocol {
    func goLogin(user: String, pass: String, _ output: @escaping(AuthDataResult?, Error?) -> Void)
}

class LoginService: LoginServiceProtocol {
    private let firebaseAuth = FirebaseAuthentcation()
    
    func goLogin(user: String, pass: String, _ output: @escaping (AuthDataResult?, Error?) -> Void) {
        firebaseAuth.firebaseAuth(user: user, pass: pass) { response, error in
            output(response, error)
        }
    }
}

