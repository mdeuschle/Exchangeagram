//
//  CommentsViewController.swift
//  Exchangeagram
//
//  Created by Matt Deuschle on 2/11/16.
//  Copyright © 2016 CJM Inc. All rights reserved.
//

import UIKit

class CommentsViewController: UIViewController {
    
    @IBOutlet weak var commentTextComments: UITextField!

    @IBOutlet weak var sendButton: UIButton!

    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return 0;
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        return UITableViewCell()
    }

    @IBAction func onSendButtonPressed(sender: UIButton) {

    }    
    
}
