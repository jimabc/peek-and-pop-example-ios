//
//  ProfileViewController.swift
//  PeekAndPopExample
//
//  Created by James Matteson on 1/21/17.
//  Copyright © 2017 James Matteson. All rights reserved.
//

import Foundation
import UIKit

class ProfileViewController: UIViewController {
    
    // MARK: - Public properties
    
    var message: Message? {
        didSet {
            let maxWidth = min(view.bounds.height, view.bounds.width)
            let imageWidth = maxWidth * 0.5
            
            imageView.image = message?.emoji.emojiImage(width: imageWidth)
            titleLabel.text = message?.name
        }
    }
    
    // MARK: - Private Properties
    
    fileprivate let titleInsets = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
    
    fileprivate lazy var contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    fileprivate lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    fileprivate lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 24, weight: UIFontWeightSemibold)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Profile"
        
        // Configure view
        view.backgroundColor = UIColor.emojiYellow
        
        // Compose child views
        contentView.addSubview(imageView)
        contentView.addSubview(titleLabel)
        
        view.addSubview(contentView)
        
        // Attach image view
        contentView.addAnchors([.top, .horizontal], to: imageView)
        
        // Attach title label
        titleLabel.setContentCompressionResistancePriority(UILayoutPriorityRequired, for: .vertical)
        titleLabel.setContentHuggingPriority(UILayoutPriorityRequired, for: .vertical)
        
        titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor).isActive = true
        contentView.addAnchors([.bottom, .horizontal], to: titleLabel, insets: titleInsets)
        
        // Attach content view
        view.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        view.addAnchors(.horizontal, to: contentView)
    }
}
