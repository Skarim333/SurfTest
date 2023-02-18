//
//  UIView + Extension.swift
//  SurfTest
//
//  Created by Карим Садыков on 13.02.2023.
//

import UIKit

extension UIView {
    func toAutoLayout() {
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func addSubviews(_ views: [UIView]) {
        views.forEach{ addSubview($0) }
    }
    
    var width: CGFloat {
        return frame.size.width
    }
    var height: CGFloat {
        return frame.size.height
    }
    var left: CGFloat {
        return frame.origin.x
    }
    var right: CGFloat {
        return left + width
    }
    var top: CGFloat {
        return frame.origin.y
    }
    var bottom: CGFloat {
        return top + height
    }
    
}

// MARK: - StackView Extension

extension UIStackView {
    func addSubviewsToStack(_ views: [UIView]) {
        views.forEach{ addArrangedSubview($0) }
    }
}

