//
//  FirebsaseRequests.swift
//  coppelExam
//
//  Created by MacBook Air on 24/02/23.
//

import Foundation
import FirebaseFirestore

class FirebaseRequests {
    private let db = Firestore.firestore()
    
    func firebaseRequest(collection: String, uid: String, _ output: @escaping(DocumentSnapshot?, Error?) -> Void) {
        let docRef = db.collection(collection).document(uid)
        docRef.getDocument { document, error in
            output(document, error)
        }
    }
}
