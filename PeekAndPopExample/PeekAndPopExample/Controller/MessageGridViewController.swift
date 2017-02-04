//
//  MessageGridViewController.swift
//  PeekAndPopExample
//
//  Created by James Matteson on 1/21/17.
//  Copyright © 2017 James Matteson. All rights reserved.
//

import Foundation
import UIKit

class MessageGridViewController: MessagesViewController {
    
    // MARK: - Private properties
    
    fileprivate let cellReuseId = "cell"
    fileprivate let minimumItemSize: CGFloat = 60
    
    fileprivate lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: self.layout)
        collectionView.backgroundColor = UIColor.white
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    fileprivate lazy var itemSize: CGSize = {
        let itemsPerRow = floor(self.view.bounds.width / self.minimumItemSize)
        let size = self.view.bounds.width / itemsPerRow
        return CGSize(width: size,  height: size)
    }()
    
    fileprivate lazy var layout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = self.itemSize
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        return layout
    }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Compose child views
        view.addSubview(collectionView)
        view.addAnchors(.all, to: collectionView)
        
        // Register cell types
        collectionView.register(MessageGridCell.self, forCellWithReuseIdentifier: cellReuseId)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        let top = topLayoutGuide.length
        let bottom = bottomLayoutGuide.length
        let insets = UIEdgeInsets(top: top, left: 0, bottom: bottom, right: 0)
        
        collectionView.contentInset = insets
        collectionView.scrollIndicatorInsets = insets
    }
}

extension MessageGridViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.numberOfMessages
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellReuseId, for: indexPath) as! MessageGridCell
        let message = data.messages[indexPath.item]
        
        cell.imageView.image = message.emoji.emojiImage(width: itemSize.width)
        
        // User interaction must be enabled to 3D Touch images!
        cell.imageView.isUserInteractionEnabled = true
        
        // Register for 3D Touch
        if isForceTouchEnabled {
            registerForPreviewing(with: self, sourceView: cell.imageView)
        }
        
        return cell
    }
}

extension MessageGridViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let profileVC = profileViewControllerForMessage(at: indexPath)
        push(profileVC, animated: true)
    }
}

extension MessageGridViewController: UIViewControllerPreviewingDelegate {
    func previewingContext(_ previewingContext: UIViewControllerPreviewing, commit viewControllerToCommit: UIViewController) {
        push(viewControllerToCommit, animated: false)
    }
    
    func previewingContext(_ previewingContext: UIViewControllerPreviewing, viewControllerForLocation location: CGPoint) -> UIViewController? {
        let sourceView = previewingContext.sourceView
        
        guard let indexPath = collectionView.indexPathForSubview(sourceView) else {
            return nil
        }
        
        previewingContext.sourceRect = sourceView.bounds
        
        return profileViewControllerForMessage(at: indexPath)
    }
}
