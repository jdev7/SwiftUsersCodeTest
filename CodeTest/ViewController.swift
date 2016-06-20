//
//  ViewController.swift
//  TestCode
//
//  Created by Juan Navas Martin on 20/06/16.
//  Copyright © 2016 Perhapps. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let usersAPIHelper = UsersAPIHelper()
    
    var users: [User]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.usersAPIHelper.getUsersWithSuccess({ (users) in
            print("users count: \(users.count)")
            self.users = users.removeDuplicates()
            for user in users {
                print(user.email)
            }
            print("filtered users count: \(self.users?.count)")
        }) { (error) in
            print(error)
        }
    }

}

