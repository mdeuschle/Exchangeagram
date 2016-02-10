//
//  ResetPasswordViewController.swift
//  Exchangeagram
//
//  Created by Matt Deuschle on 2/8/16.
//  Copyright © 2016 CJM Inc. All rights reserved.
//

import UIKit
import Firebase

class ResetPasswordViewController: UIViewController {
    
    //Textfield
    @IBOutlet weak var emailText: UITextField!
    
    //Buttons
    @IBOutlet weak var resetButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    
    var ref = Firebase(url:"https://exchangeogram.firebaseio.com/")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Sets background image similar to the Login and Add-User pages
        let backgroundImage = UIImageView(frame: CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height))
        backgroundImage.image = UIImage(named: "loginBackgroundImage.png")
        backgroundImage.layer.zPosition = -1
        self.view.addSubview(backgroundImage)
        
        
    }
    
    //Pressed the reset button
    @IBAction func onResetButtonPressed(sender: AnyObject) {
        
        let email = emailText.text
        
        ref.resetPasswordForUser(email, withCompletionBlock: { error in
            if error != nil {
                // There was an error processing the request
                print(error?.localizedDescription)
                let alert = UIAlertController(title: "Error", message: "There was an error processing the request. Please try again", preferredStyle: UIAlertControllerStyle.Alert)
                
                let ok = UIAlertAction(title: "OK", style: UIAlertActionStyle.Cancel, handler: nil)
                
                alert.addAction(ok)
                self.presentViewController(alert, animated: true, completion: nil)
                
            } else {
                // Password reset sent successfully
                let alert = UIAlertController(title: "Success", message: "Email for resetting password has been sent to your email address", preferredStyle: UIAlertControllerStyle.Alert)
                
                //If pressed 'OK', call the self.dismiss function
                let ok = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: { (UIAlertAction) -> Void in
                    self.dismissViewControllerAnimated(true, completion: nil)
                })
                alert.addAction(ok)
                self.presentViewController(alert, animated: true, completion: nil)
            }
            
            
        })
        
    }
    
    
    //Pressed the cancel button
    @IBAction func onCancelButtonPressed(sender: AnyObject)
    {
        //Hide keyboard
        self.view.endEditing(true)
        
        self.dismissViewControllerAnimated(true, completion: nil)
        
    }
    
    
}
