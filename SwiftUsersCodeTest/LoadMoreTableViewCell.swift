//
//  LoadMoreFooterView.swift
//  SwiftUsersCodeTest
//
//  Created by Juan Navas Martin on 21/06/16.
//  Copyright © 2016 Perhapps. All rights reserved.
//

import UIKit

class LoadMoreTableViewCell: UITableViewCell {

    @IBOutlet weak var btnLoadMore: UIButton!
    weak var delegate: UsersVCActions?
    @IBAction func doLoadMore(sender: AnyObject) {
        self.delegate?.didClickLoadMore()
    }
}
