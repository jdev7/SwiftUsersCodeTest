//
//  UserTableViewCell.swift
//  TestCode
//
//  Created by Juan Navas Martin on 21/06/16.
//  Copyright © 2016 Perhapps. All rights reserved.
//

import UIKit
import AlamofireImage

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
            if let imageURL = imageURL, let url = NSURL(string: imageURL) {
                
                self.activityIndicator.startAnimating()
                self.ivUserPicture.af_setImageWithURL(url,
                                                      placeholderImage: nil,
                                                      filter: nil,
                                                      progress: nil,
                                                      progressQueue: dispatch_get_main_queue(),
                                                      imageTransition: .CrossDissolve(0.3),
                                                      runImageTransitionIfCached: true,
                                                      completion: { (response) in
                                                        self.activityIndicator.stopAnimating()
                })
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
}
