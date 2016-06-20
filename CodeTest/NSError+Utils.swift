//
//  NSError+Utils.swift
//  TestCode
//
//  Created by Juan Navas Martin on 20/06/16.
//  Copyright © 2016 Perhapps. All rights reserved.
//

import Foundation

extension NSError {
    convenience init(code: Int, description: String) {
        self.init(domain: "net.perhapps.TestCode", code: code, userInfo: [NSLocalizedDescriptionKey: description])
    }    
}
