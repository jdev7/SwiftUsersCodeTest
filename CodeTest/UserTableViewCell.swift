//
//  UserTableViewCell.swift
//  TestCode
//
//  Created by Juan Navas Martin on 21/06/16.
//  Copyright © 2016 Perhapps. All rights reserved.
//

import UIKit

protocol UsersVCActions: class {
    func didClickFavourite(cell:UserTableViewCell)
    func didClickLoadMore()
}
class UserTableViewCell: UITableViewCell {
    @IBOutlet weak var ivUserPicture: UIImageView!
    @IBOutlet weak var lblFullname: UILabel!
    @IBOutlet weak var lblEmail: UILabel!
    @IBOutlet weak var lblPhone: UILabel!
    @IBOutlet weak var btnFavourite: UIButton!
    
    weak var delegate: UsersVCActions?

    @IBAction func doFavouriteClick(sender: AnyObject) {
        self.delegate?.didClickFavourite(self)
    }
    
    func setFavouriteActive(active: Bool) {
        let color = active ? UIColor.orangeColor() : UIColor.lightGrayColor()
        self.btnFavourite.setTitleColor(color, forState: .Normal)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.setFavouriteActive(false)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setFavouriteActive(false)
    }
}
