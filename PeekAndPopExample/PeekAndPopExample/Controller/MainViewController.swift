//
//  MainViewController.swift
//  PeekAndPopExample
//
//  Created by James Matteson on 12/3/16.
//  Copyright © 2016 James Matteson. All rights reserved.
//

import UIKit

fileprivate enum SegmentIndex: Int {
    case list = 0
    case grid
    
    static func displayValues() -> [String] {
        return ["List", "Grid"]
    }
}

class MainViewController: UIViewController {
    
    fileprivate var gridVC: MessageGridViewController!
    fileprivate var listVC: MessageListViewController!
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Configure view
        view.backgroundColor = UIColor.white
        
        // Configure child views
        let data = DataSource()
        
        gridVC = MessageGridViewController(data: data)
        listVC = MessageListViewController(data: data)
        
        attachChildViewController(listVC)
        attachChildViewController(gridVC)
        
        // Create tabs
        let segmentedControl = UISegmentedControl(items: SegmentIndex.displayValues())
        segmentedControl.addTarget(
            self,
            action: #selector(segmentedControlChanged(_:)),
            for: .valueChanged)
        
        // Set the default tab
        segmentedControl.selectedSegmentIndex = SegmentIndex.list.rawValue
        segmentedControlChanged(segmentedControl)
        
        // Add tabs to the navigation bar
        navigationItem.titleView = segmentedControl
    }
    
    // MARK: - UI
    
    fileprivate func showSubview(_ subview: UIView) {
        view.subviews.forEach({
            $0.isHidden = true
        })
        
        subview.isHidden = false
    }
    
    // MARK: - Events
    
    func segmentedControlChanged(_ sender: UISegmentedControl) {
        guard let selectedSegmentIndex = SegmentIndex(rawValue: sender.selectedSegmentIndex) else {
            return
        }
        
        switch selectedSegmentIndex {
        case .grid:
            showSubview(gridVC.view)
        case .list:
            showSubview(listVC.view)
        }
    }
}
