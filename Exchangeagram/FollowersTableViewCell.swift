//
//  FollowersTableViewCell.swift
//  Exchangeagram
//
//  Created by Matt Deuschle on 2/8/16.
//  Copyright © 2016 CJM Inc. All rights reserved.
//

import UIKit

class FollowersTableViewCell: UITableViewCell {


    @IBOutlet weak var avaImg: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var followingButton: UIButton!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
