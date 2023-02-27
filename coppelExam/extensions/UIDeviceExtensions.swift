//
//  UIDeviceExtensions.swift
//  coppelExam
//
//  Created by MacBook Air on 24/02/23.
//

import Foundation
import UIKit

extension UIDevice {
    var hasNotch: Bool {
        let bottom = UIApplication.shared.keyWindow?.safeAreaInsets.bottom ?? 0
        return bottom > 0
    }
}
