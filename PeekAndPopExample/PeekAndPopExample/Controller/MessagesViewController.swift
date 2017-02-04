//
//  MessagesViewController.swift
//  PeekAndPopExample
//
//  Created by James Matteson on 2/2/17.
//  Copyright © 2017 James Matteson. All rights reserved.
//

import Foundation
import UIKit

class MessagesViewController: UIViewController {
    
    // MARK: - Public properties
    
    let data: DataSource
    
    // MARK: - Lifecycle
    
    init(data: DataSource) {
        self.data = data
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Presenters
    
    func push(_ viewControllerToPush: UIViewController, animated: Bool) {
        navigationController?.pushViewController(viewControllerToPush, animated: animated)
    }
    
    // MARK: - View factories
    
    func detailViewControllerForMessage(at indexPath: IndexPath) -> MessageDetailViewController {
        let detailVC = MessageDetailViewController()
        detailVC.message = data.messages[indexPath.item]
        return detailVC
    }
    
    func profileViewControllerForMessage(at indexPath: IndexPath) -> ProfileViewController {
        let profileVC = ProfileViewController()
        profileVC.message = data.messages[indexPath.item]
        return profileVC
    }
}
