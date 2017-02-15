//
//  MessageDetailViewController.swift
//  PeekAndPopExample
//
//  Created by James Matteson on 1/21/17.
//  Copyright © 2017 James Matteson. All rights reserved.
//

import Foundation
import UIKit

class MessageDetailViewController: UIViewController {
    
    // MARK: - Public properties
    
    var message: Message? {
        didSet {
            imageView.image = message?.emoji.emojiImage(width: 50)
            textLabel.text = message?.name
        }
    }
    
    // MARK: - Private Properties
    
    fileprivate let imageInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    fileprivate let messageInsets = UIEdgeInsets(top: 32, left: 14, bottom: 0, right: 16)
    fileprivate let textInsets = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
    
    fileprivate lazy var bubbleView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.messageBubble
        view.layer.cornerRadius = 8
        view.layer.masksToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    fileprivate lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    fileprivate lazy var messageView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    fileprivate lazy var textLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.numberOfLines = 0
        label.textAlignment = .left
        label.textColor = UIColor.white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Detail"
        
        // Configure view
        view.backgroundColor = UIColor.white
        
        // Compose child views
        bubbleView.addSubview(textLabel)
        messageView.addSubview(imageView)
        messageView.addSubview(bubbleView)
        view.addSubview(messageView)
        
        // Attach the message view
        view.addAnchors(.horizontal, to: messageView, insets: messageInsets)
        
        NSLayoutConstraint(
            item: messageView,
            attribute: .top,
            relatedBy: .equal,
            toItem: topLayoutGuide,
            attribute: .bottom,
            multiplier: 1,
            constant: messageInsets.top).isActive = true
        
        // Attach the image view
        imageView.setContentCompressionResistancePriority(UILayoutPriorityRequired, for: .horizontal)
        imageView.setContentHuggingPriority(UILayoutPriorityRequired, for: .horizontal)
        
        messageView.addAnchors(.leading, to: imageView, insets: imageInsets)
        imageView.centerYAnchor.constraint(equalTo: bubbleView.centerYAnchor).isActive = true
        
        // Attach the bubble view
        bubbleView.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 8).isActive = true
        messageView.addAnchors(.vertical, to: bubbleView)
        view.addConstraints("H:[v]-(>=0)-|", views: ["v": bubbleView])
        
        // Attach the text label
        bubbleView.addAnchors(.all, to: textLabel, insets: textInsets)
    }
}
