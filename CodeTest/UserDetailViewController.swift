//
//  UserDetailViewController.swift
//  TestCode
//
//  Created by Juan Navas Martin on 22/06/16.
//  Copyright © 2016 Perhapps. All rights reserved.
//

import UIKit

class UserDetailViewController: UIViewController {
    
    var user: User?
    
    @IBOutlet weak var ivUserPicture: UIImageView!
    @IBOutlet weak var lblUser: UILabel!
    @IBOutlet weak var lblEmail: UILabel!
    @IBOutlet weak var lblGender: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblLocation: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.activityIndicator.color = UIColor.darkGrayColor()
        if let user = self.user {
            self.loadUserInfo(user)
        }
    }
    
    private func loadUserInfo(user: User) {
        self.activityIndicator.startAnimating()
        let df = NSDateFormatter()
        df.dateFormat = "dd/MM/yyyy"
        
        
        self.ivUserPicture.loadImageInBackground(self.user?.picture.large) { 
            self.activityIndicator.stopAnimating()
        }
        self.lblUser.text = user.name.fullName
        self.lblEmail.text = user.email
        self.lblGender.text = user.gender
        self.lblDate.text = df.stringFromDate(user.registered)
        self.lblLocation.text = user.location.description
    }
}
