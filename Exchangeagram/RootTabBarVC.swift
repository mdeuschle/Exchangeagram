//
//  RootTabBarVC.swift
//  Exchangeagram
//
//  Created by Ceasar Barbosa on 2/11/16.
//  Copyright © 2016 CJM Inc. All rights reserved.
//

import UIKit

class RootTabBarVC: UITabBarController, UITabBarControllerDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate
{
    
    let picker = UIImagePickerController()
    var tab = UITabBarController()
    var newImage: UIImage!
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        //picker.delegate = self
        tab.delegate = self
        

    }
    
    override func tabBar(tabBar: UITabBar, didSelectItem item: UITabBarItem)
    {
        if item.tag == 2
        {
            picker.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
            picker.allowsEditing = true
            self.presentViewController(picker, animated: true, completion: nil)
        }
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject])
    {
        newImage = info[UIImagePickerControllerEditedImage] as! UIImage
        picker.dismissViewControllerAnimated(true, completion: nil)
        
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController)
    {
        picker.dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?)
    {
        let dvc = segue.destinationViewController as! PhotoVC
        dvc.sentImage = newImage
        
    }
    
    
    
}
