//
//  PhotoVC.swift
//  Exchangeagram
//
//  Created by Ceasar Barbosa on 2/11/16.
//  Copyright © 2016 CJM Inc. All rights reserved.
//

import UIKit

class PhotoVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITableViewDataSource, UITableViewDelegate
{
    
    @IBOutlet weak var takenPhotoImageView: UIImageView!
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var captionTextView: UITextView!
    var sentImage: UIImage!
    
    let picker = UIImagePickerController()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        takenPhotoImageView.image = sentImage
        
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCellWithIdentifier("CellID")
        
        return cell!
    }
    
    
    @IBAction func onShareTapped(sender: UIBarButtonItem)
    {
        
        
    }
    
    
    
    
    
    
}
