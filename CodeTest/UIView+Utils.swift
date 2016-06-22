//
//  UIView+Utils.swift
//  TestCode
//
//  Created by Juan Navas Martin on 21/06/16.
//  Copyright © 2016 Perhapps. All rights reserved.
//

import UIKit

extension UIView {
    func addCenteredSubview(subview: UIView) {
        let centerX = NSLayoutConstraint(item: subview,
                                     attribute: .CenterX,
                                     relatedBy: .Equal,
                                     toItem: self,
                                     attribute: .CenterX,
                                     multiplier: 1.0,
                                     constant: 0.0)
        let centerY = NSLayoutConstraint(item: subview,
                                         attribute: .CenterY,
                                         relatedBy: .Equal,
                                         toItem: self,
                                         attribute: .CenterY,
                                         multiplier: 1.0,
                                         constant: 0.0)
        subview.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(subview)
        self.addConstraints([centerX, centerY]);
    }
}

