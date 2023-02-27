//
//  UISegmentedControlExtensions.swift
//  coppelExam
//
//  Created by MacBook Air on 27/02/23.
//

import Foundation
import UIKit

extension UISegmentedControl {
    static func custom(frame: CGRect, listValues: [String]) -> UISegmentedControl {
        let segmentedControl = UISegmentedControl(items: listValues)
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.backgroundColor = .darkGray
        segmentedControl.selectedSegmentTintColor = .gray
        segmentedControl.frame = frame
        return segmentedControl
    }
}
