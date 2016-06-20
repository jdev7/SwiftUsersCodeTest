//
//  Location.swift
//  TestCode
//
//  Created by Juan Navas Martin on 21/06/16.
//  Copyright © 2016 Perhapps. All rights reserved.
//

import Foundation

struct Location {
    let street: String
    let city: String
    let state: String
    
    init(street: String, city: String, state: String) {
        self.street = street
        self.city = city
        self.state = state
    }
}