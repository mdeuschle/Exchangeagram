//
//  DataService.swift
//  Exchangeagram
//
//  Created by Jonathan Kilgore on 2/9/16.
//  Copyright © 2016 CJM Inc. All rights reserved.
//

import Foundation
import Firebase

let URL_BASE = "https://exchangeogram.firebaseio.com/"

class DataService {
    
    static let ds = DataService()
    
    private var _REF_BASE = Firebase(url: "\(URL_BASE)")
    //private var _REF_POST = Firebase(url: "\(URL_BASE)/post")
    private var _REF_USER = Firebase(url: "\(URL_BASE)/user")
    private var _PHOTO_REF = Firebase(url: "\(URL_BASE)/photos")
    
    var REF_BASE: Firebase {
        return _REF_BASE
    }
    
//    var REF_POST: Firebase {
//        return _REF_POST
//    }
    
    var REF_USER: Firebase {
        return _REF_USER
    }
    
    var CURRENT_USER_REF: Firebase {
        
        let userID = NSUserDefaults.standardUserDefaults().valueForKey("uid") as! String
        let currentUser = Firebase(url: "\(REF_BASE)").childByAppendingPath("users").childByAppendingPath(userID)
        return currentUser!
    }
    
    var PHOTO_REF: Firebase {
        return self.PHOTO_REF
    }
    
    func createNewAccount(uid:String, user: Dictionary<String, AnyObject>) {
        REF_USER.childByAppendingPath(uid).updateChildValues(user)
    }
    
    func createFireBasePost(uid:String, post: Dictionary<String, AnyObject>) {
        
        let firebaseNewPost = PHOTO_REF.childByAutoId()
        firebaseNewPost.setValue(post)
        
        //REF_POST.childByAppendingPath(uid).setValue(post)
    }
    
    
    
    //end of DataService class
}
