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
import MapKit
import CoreLocation

class Photos {
    
    //Variables to convert data into strings
    var photoString: String?
    var photoLikes: Int?
    var username: String?
    var userID: String?
    var caption:String?
    var location:String?
    var key: String?
    var hhmmss: String?
    var currentDate: String?
    var dateID: String?
    var comments: [String]?
    var locationCoordinate: CLLocationCoordinate2D?
    var photo: UIImage?

    
    //Initializing the image
    init(image: UIImage, captionText: String, locationPlacemark: CLPlacemark?)
    {
        userID = NSUserDefaults.standardUserDefaults().valueForKey("uid") as? String
        
        let imageData: NSData! = UIImageJPEGRepresentation(image, 0.5)
        let base64String = imageData.base64EncodedStringWithOptions([])
        
        photoString = base64String
        caption = captionText
        username = currentUsername

        //Determine data and timestamp
        let date = NSDate()
        let dateFormatterFullDate = NSDateFormatter()
        dateFormatterFullDate.dateStyle = NSDateFormatterStyle.LongStyle
        let dateString = dateFormatterFullDate.stringFromDate(date)
        let dateFormatterHHMMSS = NSDateFormatter()
        dateFormatterHHMMSS.dateFormat = "hh:mm:ss"
        let hhmmssString = dateFormatterHHMMSS.stringFromDate(date)
        
        self.hhmmss = hhmmssString
        self.currentDate = dateString
        
        userID = NSUserDefaults.standardUserDefaults().valueForKey("uid") as? String
        
        let photoDictionary = ["photoString": photoString! as String, "likes": 0, "user": username!, "userID": userID!, "caption": caption!, "location": location!, "hh:mm:ss": hhmmss!, "date": currentDate!]
        
        let photosRef = DataService.ds.PHOTO_REF.childByAutoId()
        
        photosRef.setValue(photoDictionary)
        self.dateID = String(NSDate())
        
        
        //To pull location data
        if (locationPlacemark != nil) {
            
            location = "\(locationPlacemark!.subThoroughfare!) \(locationPlacemark!.thoroughfare!) \(locationPlacemark!.locality!)"
            locationCoordinate = CLLocationCoordinate2D(latitude: locationPlacemark!.location!.coordinate.latitude, longitude: locationPlacemark!.location!.coordinate.longitude)
            
            //This will show the coordinates to verify it's working/pulling correctly
            print("coordinates are: \(locationCoordinate!)")
            
            let photoDictionary = ["photoString": photoString! as String, "likes": 0, "user": username!, "userID": userID!, "caption": caption!, "location": location!, "hh:mm:ss": hhmmss!, "date": currentDate!, "longitude": locationCoordinate!.longitude as Double, "latitude": locationCoordinate!.latitude as Double, "dateID": dateID!]
            
            photosRef.setValue(photoDictionary)
        }
        else
        {
            let photoDictionary = ["photoString": photoString! as String, "likes": 0, "user": username!, "userID": userID!, "caption": caption!, "hh:mm:ss": hhmmss!, "date": currentDate!, "dateID": dateID!]
            
            photosRef.setValue(photoDictionary)
        }
        
    }
    
    init(dictionary: Dictionary<String, AnyObject>) {
        
        photoString = dictionary["photoString"] as? String
        photoLikes = dictionary["likes"] as? Int
        
        username = dictionary["user"] as? String
        userID  = dictionary["userID"] as? String
        
        caption = dictionary["caption"] as? String
        location = dictionary["location"] as? String
        
        currentDate = dictionary["date"] as? String
        hhmmss = dictionary["hh:mm:ss"] as? String
        dateID = dictionary["dateID"] as? String
        locationCoordinate = dictionary["locationCoordinate"] as? CLLocationCoordinate2D
        
        comments = dictionary["comments"] as? Array
        
        photo = UIImage()
        key  = String()
    }
    
//end of class
}
