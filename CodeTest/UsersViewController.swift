//
//  ViewController.swift
//  TestCode
//
//  Created by Juan Navas Martin on 20/06/16.
//  Copyright © 2016 Perhapps. All rights reserved.
//

import UIKit

class UsersViewController: UIViewController {

    // MARK: - Properties
    let usersAPIHelper = UsersAPIHelper()
    
    var users: [User]? { didSet { self.filterUsers(shouldOrderData: true) } }
    var orderedUsers: [User]?
    var filteredUsers: [User]?
    
    var showingFavourites = false
    
    var searchController = UISearchController(searchResultsController: nil)
    
    @IBOutlet weak var switchGenre: UISwitch!
    @IBOutlet weak var switchName: UISwitch!
    @IBOutlet weak var tableViewUsers: UITableView!
    
    // MARK: - User Actions
    @IBAction func showFavourites(sender: AnyObject) {
        showingFavourites = !showingFavourites
        if let btnShowFavourites = sender as? UIBarButtonItem {
            btnShowFavourites.tintColor = showingFavourites ? UIColor.orangeColor() : UIColor.lightGrayColor()
        }
        self.filteredUsers = nil
        self.switchName.on = false
        self.switchGenre.on = false
        self.searchController.searchBar.text = ""
        self.searchController.active = false
        self.orderBy(self)
        if showingFavourites {
            self.navigationItem.titleView = nil
            let unfilteredUsers = self.getLoadedUsers()
            self.filteredUsers = unfilteredUsers.filter { $0.isFavourite }
        }
        else {
            self.navigationItem.titleView = self.searchController.searchBar
        }
        self.tableViewUsers.reloadData()
    }
    
    @IBAction func orderBy(sender: AnyObject) {
        self.orderUsers(self.switchGenre.on, byName: self.switchName.on)
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.configureTableView()
        self.configureSearchController()
        
        self.getUsers()
    }
    
    // MARK: - Data Manipulation
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
        else if showingFavourites {
            self.orderedUsers = self.filteredUsers
        }

        self.filterUsers(shouldOrderData: false)
        
        self.tableViewUsers.reloadData()
    }
    
    func filterUsers(shouldOrderData shouldOrderData: Bool) {
        if showingFavourites {
            self.filteredUsers = self.orderedUsers
        }
        else if let text = self.searchController.searchBar.text where text.characters.count > 0 {
            self.searchForText(text, shouldOrderData: shouldOrderData)
        }
    }
    
    func removeUser(user: User, inout array:[User]?) {
        if let index = array?.indexOf(user) {
            array?.removeAtIndex(index)
        }
    }
    
    // MARK: - Navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "openUserDetail" {
            guard let indexPath = self.tableViewUsers.indexPathForSelectedRow else {
                return
            }
            if let user = self.getUser(indexPath) {
                print(user)
            }
        }
    }
}

// MARK: - Cell User Actions
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
