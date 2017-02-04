//
//  MessageListViewController.swift
//  PeekAndPopExample
//
//  Created by James Matteson on 1/29/17.
//  Copyright © 2017 James Matteson. All rights reserved.
//

import Foundation
import UIKit

class MessageListViewController: MessagesViewController {
    
    // MARK: - Private properties
    
    fileprivate let cellReuseId = "cell"
    
    fileprivate lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = 60
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Compose child views
        view.addSubview(tableView)
        view.addAnchors(.all, to: tableView)
        
        // Register cell types
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellReuseId)
        
        // Register for 3D Touch
        if isForceTouchEnabled {
            registerForPreviewing(with: self, sourceView: tableView)
        }
    }
    
    // MARK: - UI
    
    fileprivate func configureCell(_ cell: UITableViewCell, at indexPath: IndexPath) {
        let item = data.messages[indexPath.item]
        
        cell.accessoryType = .disclosureIndicator
        cell.imageView?.contentMode = .scaleAspectFit
        cell.imageView?.image = item.emoji.emojiImage(width: 50)
        cell.textLabel?.text = item.name
        
        // User interaction must be enabled to 3D Touch images!
        cell.imageView?.isUserInteractionEnabled = true
        
        // Register for 3D Touch
        if let imageView = cell.imageView, isForceTouchEnabled {
            registerForPreviewing(with: self, sourceView: imageView)
        }
        
        // Tapping the avatar should load the profile view
        if (cell.gestureRecognizers?.count ?? 0) == 0 {
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(cellAvatarTapped(_:)))
            cell.imageView?.addGestureRecognizer(tapGesture)
        }
    }
    
    // MARK: - Events
    
    func cellAvatarTapped(_ gesture: UITapGestureRecognizer) {
        guard
            let subview = gesture.view,
            let indexPath = tableView.indexPathForSubview(subview) else {
                return
        }
        
        let profileVC = profileViewControllerForMessage(at: indexPath)
        push(profileVC, animated: true)
    }
}

// MARK: - UITableViewDataSource

extension MessageListViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.numberOfMessages
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseId, for: indexPath)
        configureCell(cell, at: indexPath)
        return cell
    }
}

// MARK: - UITableViewDelegate

extension MessageListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailVC = detailViewControllerForMessage(at: indexPath)
        push(detailVC, animated: true)
        
        // Clear selection
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

// MARK: - UIViewControllerPreviewingDelegate

extension MessageListViewController: UIViewControllerPreviewingDelegate {
    func previewingContext(_ previewingContext: UIViewControllerPreviewing, commit viewControllerToCommit: UIViewController) {
        push(viewControllerToCommit, animated: false)
    }
    
    func previewingContext(_ previewingContext: UIViewControllerPreviewing, viewControllerForLocation location: CGPoint) -> UIViewController? {
        let sourceView = previewingContext.sourceView
        
        // Check the source view to determine whether
        // to return a detail or profile view.
        if sourceView == tableView {
            guard
                let indexPath = tableView.indexPathForRow(at: location),
                let cell = tableView.cellForRow(at: indexPath),
                let imageView = cell.imageView else {
                    return nil
            }
            
            let locationInCell = cell.convert(location, from: tableView)
            
            // Ignore touches on the cell that are over the
            // profile image, otherwise, all 3D touches will
            // lead to the detail view.
            guard !imageView.frame.contains(locationInCell) else {
                return nil
            }
            
            previewingContext.sourceRect = cell.frame
            
            return detailViewControllerForMessage(at: indexPath)
        } else {
            guard let indexPath = tableView.indexPathForSubview(sourceView) else {
                return nil
            }
            
            previewingContext.sourceRect = sourceView.bounds
            
            return profileViewControllerForMessage(at: indexPath)
        }
    }
}
