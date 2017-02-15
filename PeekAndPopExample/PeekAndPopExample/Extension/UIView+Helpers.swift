//
//  UIView+Helpers.swift
//  PeekAndPopExample
//
//  Created by James Matteson on 1/24/17.
//  Copyright © 2017 James Matteson. All rights reserved.
//

import Foundation
import UIKit

struct ViewAnchors: OptionSet {
    let rawValue: Int
    
    static let bottom     = ViewAnchors(rawValue: 1 << 0)
    static let leading    = ViewAnchors(rawValue: 1 << 1)
    static let left       = ViewAnchors(rawValue: 1 << 2)
    static let right      = ViewAnchors(rawValue: 1 << 3)
    static let top        = ViewAnchors(rawValue: 1 << 4)
    static let trailing   = ViewAnchors(rawValue: 1 << 5)
    
    static let all        : ViewAnchors = [.bottom, .leading, .top, .trailing]
    static let horizontal : ViewAnchors = [.leading, .trailing]
    static let vertical   : ViewAnchors = [.bottom, .top]
}

extension UIView {
    func addAnchors(_ anchors: ViewAnchors, to view: UIView, insets: UIEdgeInsets = .zero) {
        if anchors.contains(.bottom) {
            bottomAnchor.constraint(
                equalTo: view.bottomAnchor,
                constant: insets.bottom).isActive = true
        }
        
        if anchors.contains(.leading) {
            leadingAnchor.constraint(
                equalTo: view.leadingAnchor,
                constant: -insets.left).isActive = true
        }
        
        if anchors.contains(.left) {
            leftAnchor.constraint(
                equalTo: view.leftAnchor,
                constant: -insets.left).isActive = true
        }
        
        if anchors.contains(.right) {
            rightAnchor.constraint(
                equalTo: view.rightAnchor,
                constant: insets.right).isActive = true
        }
        
        if anchors.contains(.top) {
            topAnchor.constraint(
                equalTo: view.topAnchor,
                constant: -insets.top).isActive = true
        }
        
        if anchors.contains(.trailing) {
            trailingAnchor.constraint(
                equalTo: view.trailingAnchor,
                constant: insets.right).isActive = true
        }
    }
    
    func addConstraints(_ visualFormat: String, options: NSLayoutFormatOptions = [], metrics: [String: Any]? = nil, views: [String: Any]) {
        let constraints = NSLayoutConstraint.constraints(
            withVisualFormat: visualFormat,
            options: options,
            metrics: metrics,
            views: views)
        
        addConstraints(constraints)
    }
}
