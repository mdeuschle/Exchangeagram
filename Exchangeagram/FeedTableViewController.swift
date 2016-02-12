//
//  FeedTableViewController.swift
//  Exchangeagram
//
//  Created by Matt Deuschle on 2/10/16.
//  Copyright © 2016 CJM Inc. All rights reserved.
//

import UIKit

import Firebase

class FeedTableViewController: UITableViewController {

    var posts: [String: String] = [String: String]()

    var feedArray:[String] = []

    var tapped = false

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Exchangeagram"

        feedArray = ["image1.jpg","image2.jpg","image3.jpg","image4.jpg","image5.jpg","image6.jpg","image7.jpg","image1.jpg","image2.jpg","image3.jpg","image4.jpg","image5.jpg","image6.jpg","image7.jpg"]

        navigationController?.hidesBarsOnSwipe = true;
    }


    // MARK: - Table view data source


    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return feedArray.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! FeedTableViewCell

        cell.postImage.image = UIImage(named: feedArray[indexPath.row])
        cell.likeButton.tag = indexPath.row;

        return cell
    }

    @IBAction func onLikeButtonPressed(sender: UIButton) {

        if sender.tag == 0 {

            sender.setImage(UIImage(named: "like"), forState: UIControlState.Normal)
            self.tapped = !tapped;
        }
    }



    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
