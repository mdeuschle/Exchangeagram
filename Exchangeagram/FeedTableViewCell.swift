//
//  FeedTableViewCell.swift
//  Exchangeagram
//
//  Created by Matt Deuschle on 2/10/16.
//  Copyright © 2016 CJM Inc. All rights reserved.
//

import UIKit

class FeedTableViewCell: UITableViewCell
{

    @IBOutlet weak var postImage: UIImageView!
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var userName: UIButton!
    @IBOutlet weak var timeStamp: UILabel!
    @IBOutlet weak var postTitleLabel: UILabel!
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var commentsButton: UIButton!
    @IBOutlet weak var numberOfLikeLabel: UILabel!
    @IBOutlet weak var moreButton: UIButton!



    override func awakeFromNib() {
        super.awakeFromNib()
    }

}
