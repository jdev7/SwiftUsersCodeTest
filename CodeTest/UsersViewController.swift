//
//  ViewController.swift
//  TestCode
//
//  Created by Juan Navas Martin on 20/06/16.
//  Copyright © 2016 Perhapps. All rights reserved.
//

import UIKit

class UsersViewController: UIViewController {

    let usersAPIHelper = UsersAPIHelper()
    
    var users: [User]?
    var orderedUsers: [User]?
    var filteredUsers: [User]?
    
    @IBOutlet weak var switchGenre: UISwitch!
    @IBOutlet weak var switchName: UISwitch!
    @IBOutlet weak var tableViewUsers: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableViewUsers.dataSource = self;
        self.tableViewUsers.delegate = self;
        self.tableViewUsers.estimatedRowHeight = 80;
        self.tableViewUsers.rowHeight = UITableViewAutomaticDimension;
        
        
        self.usersAPIHelper.getUsersWithSuccess({ (users) in
            print("users count: \(users.count)")
            self.users = users.removeDuplicates()
            
            self.tableViewUsers.reloadData()
            for user in users {
                print(user.email)
            }
            print("filtered users count: \(self.users?.count)")
        }) { (error) in
            print(error)
        }
    }
    
    func getUser(indexPath: NSIndexPath) -> User? {
        if let filteredUsers = self.filteredUsers {
            return filteredUsers[indexPath.row]
        }
        else if let orderedUsers = self.orderedUsers {
            return orderedUsers[indexPath.row]
        }
        else if let users = self.users {
            return users[indexPath.row]
        }
        return nil
    }
    
    @IBAction func orderByGenre(sender: AnyObject) {
        
    }
    @IBAction func orderByName(sender: AnyObject) {
        
    }
}

extension UsersViewController: UsersVCActions {
    func didClickLoadMore() {
        print("load More")
    }
    func didClickFavourite(cell: UserTableViewCell) {
        print("favourite")
    }
}

extension UsersViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let filteredUsers = self.filteredUsers {
            return filteredUsers.count
        }
        else if let orderedUsers = self.orderedUsers {
            return orderedUsers.count
        }
        else if let users = self.users {
            return users.count
        }
        return 0
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView .dequeueReusableCellWithIdentifier("userCell", forIndexPath: indexPath) as! UserTableViewCell
        
        let user = self.getUser(indexPath)
        
        cell.lblEmail.text = user?.email
        cell.lblFullname.text = user?.name.fullName
        cell.lblPhone.text = user?.phone
        
        cell.delegate = self
        
        return cell
    }
    
    func tableView(tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        if let footerView = tableView.dequeueReusableCellWithIdentifier("loadMoreCell") as? LoadMoreTableViewCell {
            footerView.delegate = self
            return footerView
        }
        return nil
    }
}
