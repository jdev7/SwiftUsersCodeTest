//
//  UIViewController+Utils.swift
//  TestCode
//
//  Created by Juan Navas Martin on 21/06/16.
//  Copyright © 2016 Perhapps. All rights reserved.
//

import UIKit

struct VCConstants {
    static let kContainerViewTag = 10001
}

extension UIViewController {
    
    func showLoading() {
        let containerView = UIView()
        containerView.tag = VCConstants.kContainerViewTag
        containerView.backgroundColor = UIColor.blackColor()
        containerView.alpha = 0.5
        
        let spinner = UIActivityIndicatorView(activityIndicatorStyle: .WhiteLarge)
        
        self.addSubviewConstrainedToSuperview(containerView)
        containerView.addCenteredSubview(spinner)
        
        spinner.startAnimating()
    }
    
    func stopLoading() {
        self.view.viewWithTag(VCConstants.kContainerViewTag)?.removeFromSuperview()
    }
    
    func addSubviewConstrainedToSuperview(subview: UIView) {
        let left = NSLayoutConstraint(item: subview,
                                      attribute: .Leading,
                                      relatedBy: .Equal,
                                      toItem: self.view,
                                      attribute: .Leading,
                                      multiplier: 1.0,
                                      constant: 0.0)
        let top = NSLayoutConstraint(item: subview,
                                     attribute: .Top,
                                     relatedBy: .Equal,
                                     toItem: self.topLayoutGuide,
                                     attribute: .Bottom,
                                     multiplier: 1.0,
                                     constant: 0.0)
        let right = NSLayoutConstraint(item: subview,
                                       attribute: .Trailing,
                                       relatedBy: .Equal,
                                       toItem: self.view,
                                       attribute: .Trailing,
                                       multiplier: 1.0,
                                       constant: 0.0)
        let bottom = NSLayoutConstraint(item: subview,
                                        attribute: .Bottom,
                                        relatedBy: .Equal,
                                        toItem: self.bottomLayoutGuide,
                                        attribute: .Top,
                                        multiplier: 1.0,
                                        constant: 0.0)
        subview.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(subview)
        self.view.addConstraints([left, top, right, bottom])
    }
}
