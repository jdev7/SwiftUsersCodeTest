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
    
    @IBOutlet private weak var ivUserPicture: UIImageView!
    @IBOutlet weak var lblFullname: UILabel!
    @IBOutlet weak var lblEmail: UILabel!
    @IBOutlet weak var lblPhone: UILabel!
    @IBOutlet weak var btnFavourite: UIButton!
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var imageURL: String? {
        didSet {
            self.activityIndicator.startAnimating()
            self.ivUserPicture.loadImageInBackground(imageURL) { 
                self.activityIndicator.stopAnimating()
            }
        }
    }
    override func willMoveToSuperview(newSuperview: UIView?) {
        if (newSuperview == nil) {
            self.ivUserPicture.af_cancelImageRequest()
        }
    }
    weak var delegate: UsersVCActions?

    @IBAction func doFavouriteClick(sender: AnyObject) {
        self.delegate?.didClickFavourite(self)
    }
    
    func setFavouriteActive(active: Bool?) {
        guard let active = active else {
            return
        }
        let color = active ? UIColor.orangeColor() : UIColor.lightGrayColor()
        self.btnFavourite.setTitleColor(color, forState: .Normal)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.setFavouriteActive(false)
        self.imageView?.image = nil
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setFavouriteActive(false)
    }
    
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        self.ivUserPicture.layer.cornerRadius = self.ivUserPicture.frame.width / 2
        self.ivUserPicture.layer.masksToBounds = true
    }
}
