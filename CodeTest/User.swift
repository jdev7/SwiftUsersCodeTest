//
//  User.swift
//  TestCode
//
//  Created by Juan Navas Martin on 20/06/16.
//  Copyright © 2016 Perhapps. All rights reserved.
//

import Foundation

struct User: Hashable, Equatable {
    let gender: String
    let email: String
    let phone: String
    let registered: NSDate
    let name: UserName
    let location: Location
    let picture: Picture
    
    
    init(gender: String, email:String, phone: String, registered: NSDate, name: UserName, location: Location, picture: Picture) {
        self.gender = gender
        self.email = email
        self.phone = phone
        self.registered = registered
        self.name = name
        self.location = location
        self.picture = picture
    }
    
    var hashValue: Int {
        get {
            return self.email.hashValue ^ self.phone.hashValue ^ self.name.hashValue
        }
    }
}
func ==(lhs: User, rhs: User) -> Bool {
    return lhs.email == rhs.email && lhs.phone == rhs.phone && lhs.name == rhs.name
}

