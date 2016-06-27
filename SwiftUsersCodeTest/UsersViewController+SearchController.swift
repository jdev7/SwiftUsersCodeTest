//
//  UsersViewController+SearchController.swift
//  SwiftUsersCodeTest
//
//  Created by Juan Navas Martin on 22/06/16.
//  Copyright © 2016 Perhapps. All rights reserved.
//

import UIKit

// MARK: - Search Controller
extension UsersViewController: UISearchBarDelegate, UISearchResultsUpdating {
    
    func configureSearchController () {
        self.searchController.searchResultsUpdater = self
        self.searchController.dimsBackgroundDuringPresentation = false
        self.searchController.hidesNavigationBarDuringPresentation = false
        self.searchController.searchBar.delegate = self
        self.searchController.searchBar.barTintColor = UIColor.clearColor()
        self.searchController.searchBar.backgroundImage = UIImage()
        self.navigationItem.titleView = self.searchController.searchBar
        self.searchController.searchBar.sizeToFit()
        
        self.definesPresentationContext = false
    }
    
    func updateSearchResultsForSearchController(searchController: UISearchController) {
        if let search = searchController.searchBar.text {
            self.searchForText(search, shouldOrderData: true)
            self.tableViewUsers.reloadData()
        }
    }
    
    func searchForText(text: String, shouldOrderData: Bool) {
        
        let namePredicate = NSPredicate(format: "SELF.name.firstName CONTAINS[c] %@", text)
        let surnamePredicate = NSPredicate(format: "SELF.name.lastName CONTAINS[c] %@", text)
        let emailPredicate = NSPredicate(format: "SELF.email CONTAINS[c] %@", text)
        let finalPredicate = NSCompoundPredicate(orPredicateWithSubpredicates: [namePredicate, surnamePredicate, emailPredicate])
        
        self.filteredUsers = nil
        if shouldOrderData {
            self.orderBy(self)
        }
        let unfilteredUsers = self.getLoadedUsers()
        
        if text.characters.count > 0 {
            self.filteredUsers = unfilteredUsers.filter { finalPredicate.evaluateWithObject($0) }
        }
    }
    
    func searchBarTextDidBeginEditing(searchBar: UISearchBar) {
        searchBar.showsCancelButton = true
    }
    
    func searchBarTextDidEndEditing(searchBar: UISearchBar) {
        searchBar.showsCancelButton = false
    }
    
    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
        searchBar.text = ""
        searchBar.showsCancelButton = false
    }
}
