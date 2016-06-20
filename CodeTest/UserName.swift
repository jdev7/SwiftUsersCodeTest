//
//  UserName.swift
//  TestCode
//
//  Created by Juan Navas Martin on 21/06/16.
//  Copyright © 2016 Perhapps. All rights reserved.
//

import Foundation

struct UserName: Equatable, Hashable {
    let first: String
    let last: String
    
    init(first: String, last: String) {
        self.first = first
        self.last = last
    }
    
    var hashValue: Int {
        get {
            return self.first.hashValue ^ self.last.hashValue
        }
    }
}

func ==(lhs: UserName, rhs: UserName) -> Bool {
    return lhs.first == rhs.first && lhs.last == rhs.last
}
