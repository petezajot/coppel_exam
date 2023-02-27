//
//  DefaultData.swift
//  coppelExam
//
//  Created by MacBook Air on 24/02/23.
//

import Foundation

class DefaultData{
    func persistString(key: String, value: String){
        UserDefaults.standard.set(value, forKey: key)
    }
    
    func getString(key: String) -> String {
        if let value = UserDefaults.standard.string(forKey: key) {
            return value
        }
        return String()
    }
    
    func cleanPersistance() {
        let domain = Bundle.main.bundleIdentifier!
        UserDefaults.standard.removePersistentDomain(forName: domain)
        UserDefaults.standard.synchronize()
    }
}
