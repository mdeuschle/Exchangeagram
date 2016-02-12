//
//  Twitter Functionality.swift
//  Exchangeagram
//
//  Created by Jonathan Kilgore on 2/10/16.
//  Copyright © 2016 CJM Inc. All rights reserved.
//

import Foundation
import UIKit
import Firebase

extension SignInViewController {
    
    
    func authWithTwitter() {
        authHelper.selectTwitterAccountWithCallback { (error, accounts) -> Void in
            
            self.accounts = accounts as? [ACAccount]
            //            self.selectTwitterAccount(self.accounts)
            self.handleMultipleTwitterAccounts(self.accounts)
            
            
        }
    }
    
    func authAccount(account: ACAccount) {
        authHelper.authenticateAccount(account, withCallback: { (error, authData) -> Void in
            if error != nil {
                //There was an error authenticating
                print("There was an error autheniticating")
                print(error.description)
                
            } else {
                //We have an authenticated Twitter user
                print(authData.providerData.description)
                
                //array of dictionaries from the twitter account
                // let profileData= authData.providerData["cachedUserProfile"] as! NSDictionary
                //print(profileData)
                
                let user = ["provider": authData.provider, "username": "\(authData.providerData["username"]!)"]
                DataService.ds.createNewAccount(authData.uid, user: user)
                
                NSUserDefaults.standardUserDefaults().setValue(authData.uid, forKey: "\(authData.uid)")
                NSUserDefaults.standardUserDefaults().synchronize()
                
                let appDelegate : AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
                appDelegate.login()
                
            }
        })
    }
    
    
    func selectTwitterAccount(accounts: [ACAccount]) {
        let selectUserAlertController = UIAlertController(title: "Select Twitter Account", message: "Please choose your account", preferredStyle: .ActionSheet)
        
        for account in accounts {
            selectUserAlertController.addAction(UIAlertAction(title: account.username, style: .Default, handler: { alertAction in
                let currentTwitterHandle = account.username
                for acc in accounts {
                    if acc.username == currentTwitterHandle {
                        self.authAccount(acc)
                    }
                }
                }
                )
            )
            //            selectUserActionSheet.addButtonWithTitle(account.username)
        }
        selectUserAlertController.addAction(UIAlertAction(title: "Cancel", style: .Cancel, handler: nil))
        //        selectUserActionSheet.cancelButtonIndex = selectUserActionSheet.addButtonWithTitle("Cancel")
        presentViewController(selectUserAlertController, animated: true, completion: nil)
    }
    
    func handleMultipleTwitterAccounts(accounts: [ACAccount]) {
        switch accounts.count {
        case 0:
            UIApplication.sharedApplication().openURL(NSURL(string: "https://twitter.com/signup")!)
        case 1:
            self.authAccount(accounts[0])
        default:
            self.selectTwitterAccount(accounts)
        }
    }
    
    
    
    
    
    
    
    
    
    
    //end of extension
}
