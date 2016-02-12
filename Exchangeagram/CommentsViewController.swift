//
//  CommentsViewController.swift
//  Exchangeagram
//
//  Created by Matt Deuschle on 2/11/16.
//  Copyright © 2016 CJM Inc. All rights reserved.
//

import UIKit

import Firebase

class CommentsViewController: UITableViewController {

    var posts: [String: String] = [String: String]()

    @IBOutlet var commentsTableView: UITableView!
    @IBOutlet weak var textField: UITextField!

    var ref = Firebase(url: "https://exchangeogram.firebaseio.com/")

    override func viewDidLoad() {
        super.viewDidLoad()

        ref.observeEventType(.Value, withBlock:
            {

                snapshot in

                self.posts = snapshot.value.objectForKey("Posts") as! [String: String]
                print(self.posts)
                self.tableView.reloadData()
        })
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return self.posts.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = self.tableView.dequeueReusableCellWithIdentifier("Cell")
        var keys: Array = Array(self.posts.keys)
        cell?.textLabel?.text = posts[keys[indexPath.row]] as String!

        return cell!
    }

    @IBAction func onSendButtonPressed(sender: UIBarButtonItem) {
            ref.childByAppendingPath("Posts").childByAutoId().setValue(textField.text)
    }
}
