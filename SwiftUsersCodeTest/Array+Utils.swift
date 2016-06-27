//
//  Array+Utils.swift
//  SwiftUsersCodeTest
//
//  Created by Juan Navas Martin on 21/06/16.
//  Copyright © 2016 Perhapps. All rights reserved.
//

import Foundation

extension Array where Element: Hashable {
    func removeDuplicates() -> [Element] {
        return Array(Set(self))
    }
}
