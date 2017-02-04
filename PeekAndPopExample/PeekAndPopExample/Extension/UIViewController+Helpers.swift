//
//  UIViewController+Helpers.swift
//  PeekAndPopExample
//
//  Created by James Matteson on 1/21/17.
//  Copyright © 2017 James Matteson. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    var isForceTouchEnabled: Bool {
        return traitCollection.forceTouchCapability == .available
    }
    
    func attachChildViewController(_ viewController: UIViewController) {
        addChildViewController(viewController)
        view.addSubview(viewController.view)
        viewController.didMove(toParentViewController: self)
    }
}
