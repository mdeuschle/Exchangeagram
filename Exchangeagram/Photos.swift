//
//  Photos.swift
//  Exchangeagram
//
//  Created by Jonathan Kilgore on 2/11/16.
//  Copyright © 2016 CJM Inc. All rights reserved.
//

import Foundation
import UIKit
import Firebase

class Photos {
    
    //Variables to convert data into strings
    var photoString: String?
    var photoLikes: Int?
    var username: String?
    var userID: String?
    var photo: UIImage?
    var caption:String?
    var location:String?
    var key: String?
    var hhmmss: String?
    var currentDate: String?
    var dateID: String?
    
    //Initializing the image
    init(image: UIImage, captionText: String, locationString:String) {
        
        let imageData: NSData! = UIImageJPEGRepresentation(image, 0.5)
        let base64String = imageData.base64EncodedStringWithOptions([])
        
        photoLikes = 0
        username = currentUser
        photoString = base64String
        caption = captionText
        location = locationString
        
        let date = NSDate()
        let calendar = NSCalendar.currentCalendar()
        let month = calendar.components(.Month, fromDate: date)
        let year = calendar.components(.Year, fromDate: date)
        let day = calendar.components(.Day, fromDate: date)
        let hours = calendar.components(.Hour, fromDate: date)
        let minutes = calendar.components(.Minute, fromDate: date)
        let seconds = calendar.components(.Second, fromDate: date)
        self.hhmmss = "\(hours):\(minutes):\(seconds)"
        self.currentDate = "\(month) \(day), \(year)"
        self.dateID = String(NSDate())
        
        
        
        
        userID = NSUserDefaults.standardUserDefaults().valueForKey("uid") as? String
        
        let photoDictionary = ["photoString"    : photoString! as String,
            "likes"        : photoLikes!,
            "user"         : username!,
            "userID"       : userID!,
            "caption"       : caption!,
            "location"      : location!,
            "hh:mm:ss"     : hhmmss!,
            "date"          : currentDate!,
            "dateID"        : dateID!]
        
        let photosRef = DataService.ds.PHOTO_REF.childByAutoId()
        
        
        photosRef.setValue(photoDictionary)
        
    }
    
    init(dictionary: Dictionary<String, AnyObject>) {
        
        photoString = dictionary["photoString"] as? String
        photoLikes = dictionary["photoLikes"] as? Int
        username = dictionary["user"] as? String
        userID  = dictionary["userID"] as? String
        caption = dictionary["caption"] as? String
        location = dictionary["location"] as? String
        photo = UIImage()
        key  = String()
        
        
        
    }
    
//end of class
}
