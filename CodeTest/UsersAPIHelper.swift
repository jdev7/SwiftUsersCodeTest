	//
//  UsersAPIHelper.swift
//  TestCode
//
//  Created by Juan Navas Martin on 20/06/16.
//  Copyright © 2016 Perhapps. All rights reserved.
//

import UIKit
import SwiftyJSON
    
class UsersAPIHelper: NSObject {

    let restClient = RESTClientImplementation()
    
    func getUsersWithSuccess(success:(users: [User]) -> Void, fail:RESTClientFailBlock) {
        let urlString = "http://api.randomuser.me/"
        let params = ["results": 40]
        restClient.getUrl(urlString, parameters: params, success: { (responseObject) in
            guard let usersJson = responseObject["results"] as? [AnyObject] else {
                fail(error: NSError(code: -90001, description: "No results key found in \(urlString) request"))
                return
            }
            
            print("\(usersJson)")
            var users = [User]()
            for jsonUser in usersJson {
                guard let user = UserBuilder.buildWithJSONObject(JSON(jsonUser)) as? User else {
                    fail(error: NSError(code: -90002, description: "Error parsing user \(jsonUser)"))
                    return
                }
                users.append(user);
            }
            success(users: users)
            
        }) { (error) in
            print("Error getting users from server: \(error.localizedDescription)")
            fail(error: error)
        }
        
    }    
}
