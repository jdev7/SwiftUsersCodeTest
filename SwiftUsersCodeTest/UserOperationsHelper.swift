//
//  UserOperationsHelper.swift
//  SwiftUsersCodeTest
//
//  Created by Juan Navas Martin on 21/06/16.
//  Copyright © 2016 Perhapps. All rights reserved.
//

import UIKit

class UserOperationsHelper: NSObject {
    
    class func orderByGenre(unorderedArray: [User]) -> [User] {
        return unorderedArray.sort { $0.gender < $1.gender}
    }
    
    class func orderByName(unorderedArray: [User]) -> [User] {
        return unorderedArray.sort { $0 < $1}
    }
    
    class func orderByGenreAndName(unorderedArray: [User]) -> [User] {
        return unorderedArray.sort({ (u1, u2) -> Bool in
            if u1.gender != u2.gender {
                return u1.gender < u2.gender
            }
            else {
                return u1 < u2
            }
        })
    }
}
