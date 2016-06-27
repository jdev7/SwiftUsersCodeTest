//
//  UsersViewController+TableViewHandling.swift
//  SwiftUsersCodeTest
//
//  Created by Juan Navas Martin on 22/06/16.
//  Copyright © 2016 Perhapps. All rights reserved.
//

import UIKit

// MARK: - Tableview Handling
extension UsersViewController: UITableViewDelegate, UITableViewDataSource {
    
    func configureTableView() {
        self.tableViewUsers.dataSource = self
        self.tableViewUsers.delegate = self
        self.tableViewUsers.estimatedRowHeight = 80
        self.tableViewUsers.rowHeight = UITableViewAutomaticDimension
        self.tableViewUsers.allowsMultipleSelection = false
        self.tableViewUsers.keyboardDismissMode = .OnDrag
    }
    
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
        cell.imageURL = user?.picture.thumbnail
        
        cell.selectionStyle = .None
        cell.delegate = self
        
        return cell
    }
    
    func tableView(tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        if let footerView = tableView.dequeueReusableCellWithIdentifier("loadMoreCell") as? LoadMoreTableViewCell {
            footerView.delegate = self
            footerView.btnLoadMore.tintColor = showingFavourites ? UIColor.lightGrayColor() : UIColor.brownColor()
            footerView.btnLoadMore.enabled = !showingFavourites
            return footerView
        }
        return nil
    }
    
    func tableView(tableView: UITableView, editingStyleForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCellEditingStyle {
        return .Delete
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            if let user = self.getUser(indexPath) {
                self.tableViewUsers.beginUpdates()
                self.removeUser(user, array: &self.filteredUsers)
                self.removeUser(user, array: &self.orderedUsers)
                self.removeUser(user, array: &self.users)
                self.tableViewUsers.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
                self.tableViewUsers.endUpdates()
            }
        }
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.performSegueWithIdentifier("openUserDetail", sender: tableView)
    }
}
