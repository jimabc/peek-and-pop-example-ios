//
//  UICollectionView+Helpers.swift
//  PeekAndPopExample
//
//  Created by James Matteson on 2/2/17.
//  Copyright © 2017 James Matteson. All rights reserved.
//

import Foundation
import UIKit

extension UICollectionView {
    func cellForSubview(_ subview: UIView) -> UICollectionViewCell? {
        var superview = subview.superview
        
        while superview != nil {
            if superview is UICollectionViewCell {
                return superview as? UICollectionViewCell
            }
            
            superview = superview?.superview
        }
        
        return nil
    }
    
    func indexPathForSubview(_ subview: UIView) -> IndexPath? {
        if let cell = cellForSubview(subview) {
            return indexPath(for: cell)
        }
        
        return nil
    }
}
