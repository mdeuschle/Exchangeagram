//
//  ProfileViewController.swift
//  Exchangeagram
//
//  Created by Jonathan Kilgore on 2/11/16.
//  Copyright © 2016 CJM Inc. All rights reserved.
//

import UIKit
import Firebase

class ProfileViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UICollectionViewDataSource, UICollectionViewDelegate {
    
    //Properties
    var currentUserData = [FDataSnapshot]()
    var currentPhotoData = [FDataSnapshot]()
    
    var currentUser = Dictionary<String, AnyObject>()

    var userPhotosArray = [UIImage]()
    var userDefaults = NSUserDefaults.standardUserDefaults()
    
    // refresher variable
    var refresher : UIRefreshControl!
    
    // size of page
    var page : Int = 12
    
    //Storyboard Outlets
    @IBOutlet weak var postLabel: UILabel!
    @IBOutlet weak var followerLabel: UILabel!
    @IBOutlet weak var followingLabel: UILabel!
    @IBOutlet weak var fullNameLabel: UILabel!
    @IBOutlet weak var bioLabel: UILabel!
    @IBOutlet weak var segmentControl: UISegmentedControl!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var collectionViewFlow: UICollectionViewFlowLayout!
    @IBOutlet weak var userImage: UIImageView!

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // always vertical scroll
        self.collectionView?.alwaysBounceVertical = true
        
        // background color
        collectionView?.backgroundColor = .whiteColor()
        
        //Defaults to the collection view
        tableView.hidden = true
        collectionView.hidden = false
        
        // receive notification from EditProfileVC
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "reload:", name: "reload", object: nil)

    }

    override func viewWillAppear(animated: Bool) {
        setCurrentUser()
        getCurrentUserPhotos()
        
        collectionViewFlow.itemSize = CGSize.init(width: view.frame.width / 3, height: view.frame.width / 3)
    }
    
    //MARK: Custom function implemented in the viewWillAppear
    
    func setCurrentUser() {
        DataService.ds.CURRENT_USER_REF.observeSingleEventOfType(.Value, withBlock: { snapshot in
            
            print(DataService.ds.CURRENT_USER_REF)
            print(snapshot.children.allObjects)
            self.currentUser = snapshot.value as! Dictionary<String, AnyObject>
            
            self.navigationItem.title = self.currentUser["username"]!.uppercaseString
            
            self.fullNameLabel.text = self.currentUser["name"] as? String
            
            if (self.currentUser["bio"] != nil) {
                self.bioLabel.text = self.currentUser["bio"] as? String
            }
            else {
                self.bioLabel.text = "Please click 'Edit Profile' button to add a biography snippet."
                self.bioLabel.textColor = UIColor.grayColor()
            }
            
            if self.currentUser["followers"] != nil {
                self.followerLabel.text = String(self.currentUser["followers"]!.count)
            }
            
            if self.currentUser["following"] != nil {
                self.followingLabel.text = String(self.currentUser["following"]!.count)
            }
            
            if self.currentUser["userPhoto"] == nil {
                self.userImage.image = UIImage(named: "blankimage")
            } else {
                let decodedData = NSData(base64EncodedString: (self.currentUser["userPhoto"] as? String)!, options: NSDataBase64DecodingOptions())
                let decodedImage = UIImage(data: decodedData!)
                self.userImage.image = decodedImage
            }
            
            self.tableView.reloadData()
            self.collectionView.reloadData()
        })

    }
    
    func getCurrentUserPhotos() {
        DataService.ds.PHOTO_REF.observeEventType(.Value, withBlock: { snapshots in
            
            self.userPhotosArray.removeAll()
            self.currentPhotoData.removeAll()
            
            for snapshot in snapshots.children.allObjects as! [FDataSnapshot] {
                if snapshot.value!["userID"]! as! String == self.userDefaults.stringForKey("uid")! {
                    let decodedData = NSData(base64EncodedString: (snapshot.value["photoString"] as? String)!, options: NSDataBase64DecodingOptions())
                    let decodedImage = UIImage(data: decodedData!)
                    self.userPhotosArray.insert(decodedImage!, atIndex: 0)
                    self.currentPhotoData.insert(snapshot, atIndex: 0)
                    self.postLabel.text = String(self.userPhotosArray.count)
                    self.tableView.reloadData()
                    self.collectionView.reloadData()
                }
            }
        })
    }
    
    //MARK: Segmented Control
    
    func segmentSwitch(segmentControl: UISegmentedControl) {
        
        if segmentControl.selectedSegmentIndex == 0 {
            
            tableView.hidden = true
            collectionView.hidden = false
            
        } else if segmentControl.selectedSegmentIndex == 1 {
            tableView.hidden = false
            collectionView.hidden = true

        } else if segmentControl.selectedSegmentIndex == 2 {
            performSegueWithIdentifier("MapViewSegue", sender: segmentControl)
            
        }
        
    }
    
    @IBAction func onSegmentControlPressed(segmentControl: UISegmentedControl) {
        segmentSwitch(segmentControl)
    }
    
    //MARK: Tableview and Datasource
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell")! as! PhotoFeedTableViewCell
        let postImage = userPhotosArray[indexPath.row]
        let postData = currentPhotoData[indexPath.row]
        
        cell.photoView?.image = postImage
        cell.userNameLabel?.text = currentUser["username"] as? String
        
        let likesString = String(postData.value["likes"] as! Int)
        
        cell.likeCountLabel?.text = "Likes: \(likesString)"
        cell.commentTxtView?.text = postData.value["caption"] as? String
        cell.timestampLabel.text = postData.value?["timestamp"] as? String
        cell.commentsLabel?.text = postData.value?["comments"] as? String
        
        if postData.value["dateID"] as? String == String(NSDate()) {
            cell.timestampLabel.text = postData.value["hh:mm:ss"] as? String
        } else {
            cell.timestampLabel.text = postData.value["date"] as? String
        }
        
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userPhotosArray.count
    }
    
    //MARK: CollectionView
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("Cell", forIndexPath: indexPath) as! CollectionViewCell
        
        let currentPhoto = userPhotosArray[indexPath.row]
        cell.photoView.image = currentPhoto
        
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return userPhotosArray.count
    }
    
    //MARK: Prepare and Unwind Segues
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "MapViewSegue" {
            let mapVC = segue.destinationViewController as? MapViewViewController
            mapVC!.currentPhotoData = self.currentPhotoData
        }
        
    }
    
    @IBAction func unwind(segue: UIStoryboardSegue) {
        
    }
    


//end of class
}
