//
//  LoadMoreFooterView.swift
//  TestCode
//
//  Created by Juan Navas Martin on 21/06/16.
//  Copyright © 2016 Perhapps. All rights reserved.
//

import UIKit

class LoadMoreTableViewCell: UITableViewCell {

    weak var delegate: UsersVCActions?
    @IBAction func doLoadMore(sender: AnyObject) {
        self.delegate?.didClickLoadMore()
    }
}
