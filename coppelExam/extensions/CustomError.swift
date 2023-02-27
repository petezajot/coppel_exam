//
//  CustomError.swift
//  coppelExam
//
//  Created by MacBook Air on 24/02/23.
//

import Foundation

extension Error {
    var errorDomain: String? {
        return (self as NSError).domain
    }
}
