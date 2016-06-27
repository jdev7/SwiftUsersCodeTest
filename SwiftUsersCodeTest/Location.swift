//
//  Location.swift
//  SwiftUsersCodeTest
//
//  Created by Juan Navas Martin on 21/06/16.
//  Copyright © 2016 Perhapps. All rights reserved.
//

import Foundation

struct Location {
    let street: String
    let city: String
    let state: String
}

extension Location: CustomStringConvertible {
    var description: String { return "\(street)\n\(city) - \(state)" }
}
