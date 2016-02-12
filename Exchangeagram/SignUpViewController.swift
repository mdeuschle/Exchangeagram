//
//  SignUpViewController.swift
//  Exchangeagram
//
//  Created by Matt Deuschle on 2/8/16.
//  Copyright © 2016 CJM Inc. All rights reserved.
//

import UIKit
import Firebase

class SignUpViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {
    
    
    //Label
    @IBOutlet weak var titleLabel: UILabel!
    
    //Textfields
    @IBOutlet weak var usernameTxt: UITextField!
    @IBOutlet weak var passwordTxt: UITextField!
    @IBOutlet weak var repeatPasswordTxt: UITextField!
    @IBOutlet weak var fullNameTxt: UITextField!
    @IBOutlet weak var bioTxt: UITextField!
    @IBOutlet weak var websiteTxt: UITextField!
    @IBOutlet weak var emailTxt: UITextField!
    
    //Resets the default size
    var scrollViewHeight : CGFloat = 0
    
    //Scrollview
    @IBOutlet weak var scroller: UIScrollView!
    
    
    //Buttons
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    
    //Keyboard frame size
    var keyboard = CGRect()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Scrollview frame size
        scroller.frame = CGRectMake(0, 0, self.view.frame.width, self.view.frame.height)
        scroller.contentSize.height = self.view.frame.height
        scrollViewHeight = scroller.frame.size.height
        
        // alignment
        titleLabel.frame = CGRectMake(10, 40, self.view.frame.size.width - 20, 30)
        usernameTxt.frame = CGRectMake(10, titleLabel.frame.origin.y + 90, self.view.frame.size.width - 20, 30)
        passwordTxt.frame = CGRectMake(10, usernameTxt.frame.origin.y + 40, self.view.frame.size.width - 20, 30)
        repeatPasswordTxt.frame = CGRectMake(10, passwordTxt.frame.origin.y + 40, self.view.frame.size.width - 20, 30)
        emailTxt.frame = CGRectMake(10, repeatPasswordTxt.frame.origin.y + 60, self.view.frame.size.width - 20, 30)
        fullNameTxt.frame = CGRectMake(10, emailTxt.frame.origin.y + 40, self.view.frame.size.width - 20, 30)
        bioTxt.frame = CGRectMake(10, fullNameTxt.frame.origin.y + 40, self.view.frame.size.width - 20, 30)
        websiteTxt.frame = CGRectMake(10, bioTxt.frame.origin.y + 40, self.view.frame.size.width - 20, 30)
        
        signUpButton.frame = CGRectMake(20, websiteTxt.frame.origin.y + 50, self.view.frame.size.width / 4, 30)
        signUpButton.layer.cornerRadius = signUpButton.frame.size.width / 20
        
        cancelButton.frame = CGRectMake(self.view.frame.size.width - self.view.frame.size.width / 4 - 20, signUpButton.frame.origin.y, self.view.frame.size.width / 4, 30)
        cancelButton.layer.cornerRadius = cancelButton.frame.size.width / 20
        
        //Check notifications if keyboard is showing or not
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "showKeyboard:", name: UIKeyboardWillShowNotification, object: nil)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "hideKeyboard:", name: UIKeyboardWillHideNotification, object: nil)
        
        //Allows the user to hide the keyboard when selecting any part of the scrollView grid
        //Declares the hide keyboard tapped method
        let hideTap = UITapGestureRecognizer(target: self, action: "hideKeyboardTap:")
        hideTap.numberOfTapsRequired = 1
        self.view.userInteractionEnabled = true
        self.view.addGestureRecognizer(hideTap)
        
        //rounds the image from a square to circle
        //      imageView.layer.cornerRadius = imageView.frame.size.width / 2
        //      imageView.clipsToBounds = true
        
        //Declares the selected image tapped
        //        let avatarTap = UITapGestureRecognizer(target: self, action: "loadImg:")
        //        avatarTap.numberOfTapsRequired = 1
        //        imageView.userInteractionEnabled = true
        //        imageView.addGestureRecognizer(avatarTap)
        
        let backgroundImage = UIImageView(frame: CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height))
        backgroundImage.image = UIImage(named: "loginBackgroundImage.png")
        backgroundImage.layer.zPosition = -1
        self.view.addSubview(backgroundImage)
        
        
    }
    
    //MARK: TextField Delegate Functions
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        return textField.resignFirstResponder()
    }
    
    
//    //Call picker method to select image
//    func loadImg(recognizer: UIGestureRecognizer) {
//        
//        let picker = UIImagePickerController()
//        picker.delegate = self
//        picker.sourceType = .PhotoLibrary
//        
//        //Allows for cropping when selecting a photo from your library
//        picker.allowsEditing = true
//        
//        presentViewController(picker, animated: true, completion: nil)
//        
//    }
    
    //    //Connect selected image to the ImageView
    //    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
    //        imageView.image = info[UIImagePickerControllerEditedImage] as? UIImage
    //        self.dismissViewControllerAnimated(true, completion: nil)
    //    }
    
    //Hide the keyboard if tapped
    func hideKeyboardTap(recognizer: UITapGestureRecognizer) {
        self.view.endEditing(true)
    }
    
    //Show keyboard function
    func showKeyboard(notification: NSNotification) {
        
        //Define keyboard sizes as they can vary
        keyboard = (notification.userInfo?[UIKeyboardFrameEndUserInfoKey]!.CGRectValue)!
        
        //Moves up the UI
        UIView.animateWithDuration(0.4) { () -> Void in
            self.scroller.frame.size.height = self.scrollViewHeight - self.keyboard.height
            
        }
    }
    
    //Hide keyboard function
    func hideKeyboard(notification: NSNotification) {
        
        //Move down the UI
        UIView.animateWithDuration(0.4) { () -> Void in
            self.scroller.frame.size.height = self.view.frame.height
        }
    }
    
    
    //Pressed to Sign Up
    @IBAction func onSignUpButtonPressed(sender: AnyObject)
    {
        print("Sign up pressed")
        
        let username = usernameTxt.text
        let email = emailTxt.text
        let password = passwordTxt.text
        let fullname = fullNameTxt.text
        let bio = bioTxt.text
        let website = websiteTxt.text
        //let image = imageView.image
        
        //Dismisses the keyboard
        self.view.endEditing(true)
        
        //If any field is empty
        if (usernameTxt.text!.isEmpty || passwordTxt.text!.isEmpty || repeatPasswordTxt.text!.isEmpty || emailTxt.text!.isEmpty || fullNameTxt.text!.isEmpty || bioTxt.text!.isEmpty || websiteTxt.text!.isEmpty) {
            
            //Alert message
            let alert = UIAlertController(title: "Error", message: "Please fill out all fields", preferredStyle: UIAlertControllerStyle.Alert)
            let ok = UIAlertAction(title: "OK", style: UIAlertActionStyle.Cancel, handler: nil)
            alert.addAction(ok)
            self.presentViewController(alert, animated: true, completion: nil)
        }
        
        //If password and re-enter password do not match
        if passwordTxt.text != repeatPasswordTxt.text {
            
            //Alert message
            let alert = UIAlertController(title: "Error", message: "Passwords do not match", preferredStyle: UIAlertControllerStyle.Alert)
            let ok = UIAlertAction(title: "OK", style: UIAlertActionStyle.Cancel, handler: nil)
            alert.addAction(ok)
            self.presentViewController(alert, animated: true, completion: nil)
        }
        
        //Send data to server to related columns
        if username != "" && email != "" && password != "" {
            
            //Set email and password for the new user
            DataService.ds.REF_BASE.createUser(email, password: password, withValueCompletionBlock: { (error, result) -> Void in
                if error != nil {
                    let alert = UIAlertController(title: "Error", message: "Having trouble creating your account. Please try again", preferredStyle: UIAlertControllerStyle.Alert)
                    let ok = UIAlertAction(title: "OK", style: UIAlertActionStyle.Cancel, handler: nil)
                    alert.addAction(ok)
                    self.presentViewController(alert, animated: true, completion: nil)
                }
                    
                else {
                    DataService.ds.REF_BASE.authUser(email, password: password, withCompletionBlock: { (error, authData) -> Void in
                        let user = ["provider": authData.provider!, "email": email!, "username": username!, "name": fullname!, "bio": bio!, "website": website!]
                        DataService.ds.createNewAccount(authData.uid, user: user)
                        
                        
                    })
                    
                    NSUserDefaults.standardUserDefaults().setValue(result["uid"], forKey: "uid")
                    self.performSegueWithIdentifier("BackToLoginSegue", sender: nil)
                }
                
                
            })
        }
        
        
    }
    
    //Pressed to cancel a sign up
    @IBAction func onCancelButtonClicked(sender: AnyObject)
    {
        print("Cancel button pressed")
        
        //Hide keyboard
        self.view.endEditing(true)
        
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
}




