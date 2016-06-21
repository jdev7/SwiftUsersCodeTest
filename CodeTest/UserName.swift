//
//  UserName.swift
//  TestCode
//
//  Created by Juan Navas Martin on 21/06/16.
//  Copyright © 2016 Perhapps. All rights reserved.
//

import Foundation

class UserName: NSObject, Comparable {
    let first: String
    let last: String
    
    var fullName: String {
        get {
            return "\(first) \(last)"
        }
    }
    
    init(first: String, last: String) {
        self.first = first
        self.last = last
    }
    
    override var hashValue: Int {
        get {
            return self.first.hashValue ^ self.last.hashValue
        }
    }
}

func ==(lhs: UserName, rhs: UserName) -> Bool {
    return lhs.first == rhs.first && lhs.last == rhs.last
}

func <(lhs: UserName, rhs: UserName) -> Bool {
    if lhs.first != rhs.first {
        return lhs.first < rhs.first
    }
    else {
        return lhs.last < rhs.last
    }
}
func <=(lhs: UserName, rhs: UserName) -> Bool {
    if lhs.first != rhs.first {
        return lhs.first <= rhs.first
    }
    else {
        return lhs.last <= rhs.last
    }
}
func >=(lhs: UserName, rhs: UserName) -> Bool {
    if lhs.first != rhs.first {
        return lhs.first >= rhs.first
    }
    else {
        return lhs.last >= rhs.last
    }
}
func >(lhs: UserName, rhs: UserName) -> Bool {
    if lhs.first != rhs.first {
        return lhs.first > rhs.first
    }
    else {
        return lhs.last > rhs.last
    }
}
