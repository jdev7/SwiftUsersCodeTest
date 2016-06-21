//
//  UserName.swift
//  TestCode
//
//  Created by Juan Navas Martin on 21/06/16.
//  Copyright © 2016 Perhapps. All rights reserved.
//

import Foundation

class UserName: NSObject, Comparable {
    let firstName: String
    let lastName: String
    
    var fullName: String {
        get {
            return "\(firstName) \(lastName)"
        }
    }
    
    init(firstName: String, lastName: String) {
        self.firstName = firstName
        self.lastName = lastName
    }
    
    override var hashValue: Int {
        get {
            return self.firstName.hashValue ^ self.lastName.hashValue
        }
    }
}

func ==(lhs: UserName, rhs: UserName) -> Bool {
    return lhs.firstName == rhs.firstName && lhs.lastName == rhs.lastName
}

func <(lhs: UserName, rhs: UserName) -> Bool {
    if lhs.firstName != rhs.firstName {
        return lhs.firstName < rhs.firstName
    }
    else {
        return lhs.lastName < rhs.lastName
    }
}
func <=(lhs: UserName, rhs: UserName) -> Bool {
    if lhs.firstName != rhs.firstName {
        return lhs.firstName <= rhs.firstName
    }
    else {
        return lhs.lastName <= rhs.lastName
    }
}
func >=(lhs: UserName, rhs: UserName) -> Bool {
    if lhs.firstName != rhs.firstName {
        return lhs.firstName >= rhs.firstName
    }
    else {
        return lhs.lastName >= rhs.lastName
    }
}
func >(lhs: UserName, rhs: UserName) -> Bool {
    if lhs.firstName != rhs.firstName {
        return lhs.firstName > rhs.firstName
    }
    else {
        return lhs.lastName > rhs.lastName
    }
}
