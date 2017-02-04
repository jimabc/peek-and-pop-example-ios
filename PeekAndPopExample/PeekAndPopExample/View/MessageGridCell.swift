//
//  MessageGridCell.swift
//  PeekAndPopExample
//
//  Created by James Matteson on 1/30/17.
//  Copyright © 2017 James Matteson. All rights reserved.
//

import Foundation
import UIKit

class MessageGridCell: UICollectionViewCell {
    
    // MARK: - Public properties
    
    lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    // MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        configureView()
    }
    
    fileprivate func configureView() {
        // Compose child views
        contentView.addSubview(imageView)
        
        // Attach the image view
        contentView.addAnchors(.all, to: imageView)
    }
}
