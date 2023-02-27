//
//  UIScrollViewExtensions.swift
//  coppelExam
//
//  Created by MacBook Air on 27/02/23.
//

import Foundation
import UIKit

extension UIScrollView {
    static func horizontalScrollView(frame: CGRect) -> UIScrollView {
        let scrollView = UIScrollView(frame: frame)
        scrollView.bounces = true
        scrollView.contentInsetAdjustmentBehavior = .never
        return scrollView
    }
}
