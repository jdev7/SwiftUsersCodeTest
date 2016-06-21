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
    
    var users: [User]? {
        didSet {
            self.orderBy(self)
        }
    }
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
        self.tableViewUsers.allowsMultipleSelection = false

        self.getUsers()
    }
    
    func getUsers () {
        self.showLoading()
        self.usersAPIHelper.getUsersWithSuccess({ (newUsers) in
            print("users count: \(newUsers.count)")
            if self.users == nil {
                self.users = [User]()
            }
            if var users = self.users {
                users += newUsers
                users = users.removeDuplicates()
                self.users = users
            }
            self.tableViewUsers.reloadData()
            self.stopLoading()
            
            print("filtered users count: \(self.users?.count)")
        }) { (error) in
            print(error)
            self.stopLoading()
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
    
    func getLoadedUsers() -> [User] {
        if let filteredUsers = self.filteredUsers {
            return filteredUsers
        }
        else if let orderedUsers = self.orderedUsers {
            return orderedUsers
        }
        else if let users = self.users {
            return users
        }
        return [User]()
    }
    
    @IBAction func orderBy(sender: AnyObject) {
        self.orderUsers(self.switchGenre.on, byName: self.switchName.on)
    }
    
    func orderUsers(byGenre: Bool, byName: Bool) {
        self.orderedUsers = nil
        
        let unorderedUsers = getLoadedUsers()
        if byGenre && byName {
            self.orderedUsers = UserOperationsHelper.orderByGenreAndName(unorderedUsers)
        }
        else if byGenre {
            self.orderedUsers = UserOperationsHelper.orderByGenre(unorderedUsers)
        }
        else if byName {
            self.orderedUsers = UserOperationsHelper.orderByName(unorderedUsers)
        }
        self.tableViewUsers.reloadData()
    }
}

extension UsersViewController: UsersVCActions {
    func didClickLoadMore() {
        self.getUsers()
    }
    func didClickFavourite(cell: UserTableViewCell) {
        if let indexPath = self.tableViewUsers.indexPathForCell(cell) {
            if let user = self.getUser(indexPath) {
                user.isFavourite = !user.isFavourite
                cell.setFavouriteActive(user.isFavourite)
            }
        }
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
        
        cell.setFavouriteActive(user?.isFavourite)
        
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
