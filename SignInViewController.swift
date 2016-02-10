//
//  SignInViewController.swift
//  Exchangeagram
//
//  Created by Matt Deuschle on 2/8/16.
//  Copyright © 2016 CJM Inc. All rights reserved.
//

import UIKit
import Firebase
//import DataService

class SignInViewController: UIViewController {
    
    //Textfields
    @IBOutlet weak var usernameTxt: UITextField!
    @IBOutlet weak var passwordTxt: UITextField!
    
    //Buttons
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var signInButton: UIButton!
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var forgotPasswordButton: UIButton!
    
    
    var ref: Firebase!
    
    var authHelper: TwitterAuthHelper!
    var accounts: [ACAccount]!
    var account = ACAccount()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // tap to hide keyboard
        let hideTap = UITapGestureRecognizer(target: self, action: "hideKeyboard:")
        hideTap.numberOfTapsRequired = 1
        self.view.userInteractionEnabled = true
        self.view.addGestureRecognizer(hideTap)
        
        
        let backgroundImage = UIImageView(frame: CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height))
        backgroundImage.image = UIImage(named: "loginBackgroundImage.png")
        backgroundImage.layer.zPosition = -1
        self.view.addSubview(backgroundImage)
        
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        ref = Firebase(url:"https://exchangeogram.firebaseio.com/")
        authHelper = TwitterAuthHelper(firebaseRef:ref, apiKey: "oQMPIlgs15oTS5yAEDhE41CQN")
    }
    
    // hide keyboard func
    func hideKeyboard(recognizer : UITapGestureRecognizer) {
        self.view.endEditing(true)
    }
    
    //Clicked sign in button
    @IBAction func onSignInButtonPressed(sender: AnyObject) {
        print("Sign in button pressed")
        
        // hide keyboard
        self.view.endEditing(true)
        
        
        // if textfields are empty
        if usernameTxt.text!.isEmpty || passwordTxt.text!.isEmpty {
            
            // show alert message
            let alert = UIAlertController(title: "Please", message: "fill in fields", preferredStyle: UIAlertControllerStyle.Alert)
            let ok = UIAlertAction(title: "OK", style: UIAlertActionStyle.Cancel, handler: nil)
            alert.addAction(ok)
            self.presentViewController(alert, animated: true, completion: nil)
        }
        
        
        //Login functions Firebase
        if let email = usernameTxt.text where usernameTxt.text != "",
            let pwd = passwordTxt.text where passwordTxt.text != ""
        {
            DataService.ds.REF_BASE.authUser(email, password: pwd, withCompletionBlock: { error, authData in
                if error != nil {
                    print(error.localizedDescription)
                    
                    // show alert message
                    let alert = UIAlertController(title: "Error", message: error!.localizedDescription, preferredStyle: UIAlertControllerStyle.Alert)
                    let ok = UIAlertAction(title: "OK", style: UIAlertActionStyle.Cancel, handler: nil)
                    alert.addAction(ok)
                    self.presentViewController(alert, animated: true, completion: nil)
                    
                    
                } else {
                    
                    DataService.ds.REF_BASE.authUser(email, password: pwd, withCompletionBlock: { (error, authData) -> Void in
                        
                        let user = ["provider": authData.provider!, "Blah":"emailTest"]
                        DataService.ds.createNewAccount(authData.uid, user: user)
                        
                        // remember user or save in App Memeory did the user login or not
                        NSUserDefaults.standardUserDefaults().setObject(authData.uid, forKey: "\(authData.uid)")
                        NSUserDefaults.standardUserDefaults().synchronize()
                        
                        // call login function from AppDelegate.swift class
                        let appDelegate : AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
                        appDelegate.login()
                    })
                    
                }
            })
        }
        
        
        
    }
    
    @IBAction func onTwitterButtonPressed(sender: UIButton) {
        self.authWithTwitter()
    }
    
    //end of class
}
