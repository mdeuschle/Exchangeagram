//
//  SignInViewController.swift
//  Exchangeagram
//
//  Created by Matt Deuschle on 2/8/16.
//  Copyright © 2016 CJM Inc. All rights reserved.
//

import UIKit
import Firebase
import FBSDKLoginKit
//import DataService

class SignInViewController: UIViewController {
    
    //Textfields
    @IBOutlet weak var usernameTxt: UITextField!
    @IBOutlet weak var passwordTxt: UITextField!
    
    //Buttons
    @IBOutlet weak var signInButton: UIButton!
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var forgotPasswordButton: UIButton!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    //@IBOutlet weak var loginButton: FBSDKLoginButton!
    
    var ref: Firebase!
    
    var authHelper: TwitterAuthHelper!
    var accounts: [ACAccount]!
    var account = ACAccount()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Font change of the Instagram label
        titleLabel.font = UIFont(name: "Pacifico", size: 25)
        
        //Alignment for all types of devices
        titleLabel.frame = CGRectMake(10, 80, self.view.frame.size.width - 20, 50)
        usernameTxt.frame = CGRectMake(10, titleLabel.frame.origin.y + 70, self.view.frame.size.width - 20, 30)
        passwordTxt.frame = CGRectMake(10, usernameTxt.frame.origin.y + 40, self.view.frame.size.width - 20, 30)
        forgotPasswordButton.frame = CGRectMake(10, passwordTxt.frame.origin.y + 30, self.view.frame.size.width - 20, 30)
        signInButton.frame = CGRectMake(20, forgotPasswordButton.frame.origin.y + 40, self.view.frame.size.width / 4, 30)
        signUpButton.frame = CGRectMake(self.view.frame.size.width - self.view.frame.size.width / 4 - 20, signInButton.frame.origin.y , self.view.frame.size.width / 4, 30)
        
        // tap to hide keyboard
        let hideTap = UITapGestureRecognizer(target: self, action: "hideKeyboard:")
        hideTap.numberOfTapsRequired = 1
        self.view.userInteractionEnabled = true
        self.view.addGestureRecognizer(hideTap)
        
        //Sets the background image
        let backgroundImage = UIImageView(frame: CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height))
        backgroundImage.image = UIImage(named: "loginBackgroundImage.png")
        backgroundImage.layer.zPosition = -1
        self.view.addSubview(backgroundImage)
        
//        //Facebook login prompt
//        let loginButton = FBSDKLoginButton()
//        loginButton.readPermissions = ["public_profile", "email", "user_friends"]
//        loginButton.center = self.view.center
//        [self.view .addSubview(loginButton)]
//        
        
        
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
                        
                        let user = ["provider": authData.provider!, "email":email]
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
