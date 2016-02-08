//
//  SignUpViewController.swift
//  Exchangeagram
//
//  Created by Matt Deuschle on 2/8/16.
//  Copyright © 2016 CJM Inc. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController {


    //Profile Image
    @IBOutlet weak var imageView: UIImageView!

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

    @IBOutlet weak var scroller: UIScrollView!


    //Buttons
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func viewDidAppear(animated: Bool) {
        //Scrollview frame size
        scroller.frame = CGRectMake(0, 0, self.view.frame.width, self.view.frame.height)
        scroller.contentSize.height = self.view.frame.height
        scrollViewHeight = scroller.frame.size.height
    }


    //Pressed to Sign Up
    @IBAction func onSignUpButtonPressed(sender: AnyObject)
    {

    }

    //Pressed to cancel a sign up
    @IBAction func onCancelButtonClicked(sender: AnyObject)
    {
        
    }

}




