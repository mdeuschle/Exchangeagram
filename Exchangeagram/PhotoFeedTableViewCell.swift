//
//  PhotoFeedTableViewCell.swift
//  Exchangeagram
//
//  Created by Jonathan Kilgore on 2/11/16.
//  Copyright © 2016 CJM Inc. All rights reserved.
//

import UIKit

protocol LikeButtonTappedDelegate {
    func likeButtonTapped (cell: PhotoFeedTableViewCell)
}

protocol CommentButtonTappedDelegate {
    func commentButtonTapped (cell: PhotoFeedTableViewCell)
}

class PhotoFeedTableViewCell: UITableViewCell {
    
    //Calling the delegate methods
    var likeDelegate: LikeButtonTappedDelegate?
    var delegate: CommentButtonTappedDelegate?

    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var timestampLabel: UILabel!
    @IBOutlet weak var likeCountLabel: UILabel!
    @IBOutlet weak var commentsLabel: UILabel!
    
    @IBOutlet weak var photoView: UIImageView!
    @IBOutlet weak var profileImage: UIImageView!
    
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var commentButton: UIButton!
    @IBOutlet weak var redoButton: UIButton!
    @IBOutlet weak var editPhotoButton: UIButton!
    
    @IBOutlet weak var commentTxtView: UITextView!
    
    //MARK: Init
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    //MARK: Delegate Functions
    @IBAction func commentButtonPressed(sender: UIButton) {
        if let delegate = self.delegate {
            delegate.commentButtonTapped(self)
        }
    }
    
    @IBAction func onLikeButtonPressed(sender: UIButton){
        if let likeDelegate = self.likeDelegate {
            likeDelegate.likeButtonTapped(self)
        }
    }
    
    //Default functions
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
