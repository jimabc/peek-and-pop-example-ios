//
//  String+Helpers.swift
//  PeekAndPopExample
//
//  Created by James Matteson on 1/21/17.
//  Copyright © 2017 James Matteson. All rights reserved.
//

import Foundation
import UIKit

extension String {
    func emojiImage(width: CGFloat) -> UIImage {
        // 1.2 is a magic number that gives a roughly centered emoji image.
        let height: CGFloat = width * 1.2
        
        return image(ofSize: CGSize(width: width, height: height),
                     font: UIFont.systemFont(ofSize: width))
    }
    
    func image(ofSize size: CGSize, font: UIFont) -> UIImage {
        let rect = CGRect(origin: CGPoint.zero, size: size)
        let scale = UIScreen.main.scale
        
        UIGraphicsBeginImageContextWithOptions(size, false, scale);
        
        // Render fill color
        UIColor.clear.set()
        UIRectFill(rect)
        
        // Render text
        let style = NSMutableParagraphStyle()
        style.alignment = .center
        (self as NSString).draw(
            in: rect,
            withAttributes: [NSFontAttributeName: font,
                             NSParagraphStyleAttributeName: style])
        
        let image = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return image
    }
    
    func unicodeName() -> String {
        let unicodeName = (self as NSString)
            .applyingTransform(StringTransform.toUnicodeName, reverse: false) ?? ""
        
        let sanitizedName = (unicodeName as NSString)
            .replacingOccurrences(of: "\\N", with: "")
            .replacingOccurrences(of: "{", with: "")
            .replacingOccurrences(of: "}", with: "")
        
        return sanitizedName
    }
}
