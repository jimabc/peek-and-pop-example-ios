//
//  UITableView+Helpers.swift
//  PeekAndPopExample
//
//  Created by James Matteson on 1/21/17.
//  Copyright © 2017 James Matteson. All rights reserved.
//

import Foundation
import UIKit

extension UITableView {
    func cellForSubview(_ subview: UIView) -> UITableViewCell? {
        var superview = subview.superview
        
        while superview != nil {
            if superview is UITableViewCell {
                return superview as? UITableViewCell
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
