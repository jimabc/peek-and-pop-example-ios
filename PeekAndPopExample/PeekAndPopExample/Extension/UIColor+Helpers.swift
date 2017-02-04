//
//  UIColor+Helpers.swift
//  PeekAndPopExample
//
//  Created by James Matteson on 1/21/17.
//  Copyright © 2017 James Matteson. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {
    class var emojiYellow: UIColor {
        return UIColor(r: 255, g: 255, b: 50, a: 1)
    }
    
    class var messageBubble: UIColor {
        return UIColor(r: 16, g: 134, b: 248, a: 1)
    }
    
    convenience init(r: UInt8, g: UInt8 , b: UInt8 , a: CGFloat) {
        self.init(
            red:   CGFloat(r) / 255,
            green: CGFloat(g) / 255,
            blue:  CGFloat(b) / 255,
            alpha: a)
    }
}
