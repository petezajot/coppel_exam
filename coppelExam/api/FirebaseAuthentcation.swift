//
//  FirebaseAuth.swift
//  coppelExam
//
//  Created by MacBook Air on 24/02/23.
//

import Foundation
import FirebaseAuth

class FirebaseAuthentcation {
    
    func firebaseAuth(user: String, pass: String, _ output: @escaping(AuthDataResult?, Error?) -> Void) {
        Auth.auth().signIn(withEmail: user, password: pass) { authResult, error in
            output(authResult, error)
        }
    }
}
