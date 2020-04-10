//
//  UIViewController+Ext.swift
//  JetFuelTakeHomeProject
//
//  Created by Tayler Moosa on 4/9/20.
//  Copyright © 2020 Tayler Moosa. All rights reserved.
//

import UIKit
fileprivate var containerView : UIView!
extension UIViewController {
    
    func displayLoadingView() {
        containerView                                   = UIView()
        containerView.frame                             = self.view.bounds
        containerView.backgroundColor                   = UIColor.systemGray2.withAlphaComponent(0.75)
        let wheel                                       = UIActivityIndicatorView()
        wheel.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(containerView)
        containerView.addSubview(wheel)
        
        NSLayoutConstraint.activate([
            wheel.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            wheel.centerXAnchor.constraint(equalTo: containerView.centerXAnchor)
        
        ])
        wheel.startAnimating()
    }
    
    func dismissLoadingView() {
        containerView.removeFromSuperview()
    }
}
