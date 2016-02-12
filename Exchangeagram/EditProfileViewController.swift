//
//  EditProfileViewController.swift
//  Exchangeagram
//
//  Created by Jonathan Kilgore on 2/11/16.
//  Copyright © 2016 CJM Inc. All rights reserved.
//

import UIKit

class EditProfileViewController: UIViewController, UITextFieldDelegate, UITextViewDelegate {
    
    var currentUser = Dictionary<String, AnyObject>()

    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var websiteTextField: UITextField!
    @IBOutlet weak var bioTextField: UITextView!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var genderTextField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()

        self.bioTextField.layer.cornerRadius = 5
        self.bioTextField.layer.borderColor = UIColor.lightGrayColor().CGColor
        self.bioTextField.layer.borderWidth = 0.5
        
        
        DataService.ds.CURRENT_USER_REF.observeSingleEventOfType(.Value, withBlock: { snapshot in
            self.currentUser = snapshot.value as! Dictionary<String, AnyObject>
            
            self.bioTextField.text = self.currentUser["Bio"] as? String
            self.bioTextField?.textColor = UIColor.blackColor()
            self.nameTextField.text = self.currentUser["name"] as? String
            self.usernameTextField.text = self.currentUser["username"] as? String
            self.websiteTextField.text = self.currentUser["website"] as? String
            self.emailTextField.text = self.currentUser["email"] as? String
            self.phoneTextField.text = self.currentUser["phoneNumber"] as? String
            
            if (self.currentUser["userPhoto"] != nil) {
                let photoData = NSData(base64EncodedString: (self.currentUser["userPhoto"] as? String)!, options: NSDataBase64DecodingOptions())
                self.userImage.image = UIImage(data: photoData!)
            } else {
                self.userImage.image = UIImage(named: "blankimage")
            }
        })
    }
    //MARK: Custom Functions
    
    
    //MARK: Actions
    @IBAction func onDoneButtonPressed(sender: UIBarButtonItem) {
        let currentUserDict = ["Bio": self.bioTextField.text, "name": self.nameTextField.text, "username": self.usernameTextField.text, "email": self.emailTextField.text, "phoneNumber": self.phoneTextField.text]
        
        DataService.ds.CURRENT_USER_REF.setValue(currentUserDict)
        let userDefaults = NSUserDefaults.standardUserDefaults()
        userDefaults.setValue(currentUserDict["username"], forKey: "currentUser")
        currentUsername = userDefaults.valueForKey("currentUser") as? String
        performSegueWithIdentifier("UnwindtoProfileSegue", sender: self)
    }
    
    
    //MARK: TextField Delegate Functions
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        return textField.resignFirstResponder()
    }
    
    
    //MARK: TextView Delegate Functions
    func textViewDidEndEditing(textView: UITextView) {
        textView.resignFirstResponder()
    }

}
