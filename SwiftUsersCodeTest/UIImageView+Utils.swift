//
//  UIImageView+Utils.swift
//  SwiftUsersCodeTest
//
//  Created by Juan Navas Martin on 22/06/16.
//  Copyright © 2016 Perhapps. All rights reserved.
//

import UIKit
import AlamofireImage

extension UIImageView {
    func loadImageInBackground(imageURL: String?, completion:(() -> Void)?) {
        if let imageURL = imageURL, let url = NSURL(string: imageURL) {
            self.af_setImageWithURL(url,
                                    placeholderImage: nil,
                                    filter: nil,
                                    progress: nil,
                                    progressQueue: dispatch_get_main_queue(),
                                    imageTransition: .CrossDissolve(0.3),
                                    runImageTransitionIfCached: true,
                                    completion: { (response) in
                                        if let completion = completion {
                                            completion()
                                        }
            })
        }
    }
}
