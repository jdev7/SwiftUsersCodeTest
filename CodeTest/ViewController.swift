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
        // Do any additional setup after loading the view, typically from a nib.
        
        self.usersAPIHelper.getUsersWithSuccess({ (users) in
            self.users = users
            for user in users {
                print(user.email)
            }
        }) { (error) in
            print(error)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

