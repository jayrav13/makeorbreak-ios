//
//  AddRequestViewController.swift
//  MakeOrBreak
//
//  Created by Jay Ravaliya on 4/2/16.
//  Copyright © 2016 JRav. All rights reserved.
//

import Foundation
import UIKit

class AddRequestViewController : UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    var photoBarButtonItem : UIBarButtonItem!
    var imagePicker : UIImagePickerController!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.whiteColor()
        self.title = "Add Request"
        
        self.photoBarButtonItem = UIBarButtonItem(title: "Photo", style: UIBarButtonItemStyle.Plain, target: self, action: "photoButtonPressed:")
        self.navigationItem.rightBarButtonItem = self.photoBarButtonItem
        
        self.imagePicker = UIImagePickerController()
        self.imagePicker.delegate = self
        self.imagePicker.sourceType = UIImagePickerControllerSourceType.Camera
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func photoButtonPressed(sender: UIButton) {
        self.presentViewController(self.imagePicker, animated: true) { () -> Void in
            
        }
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?) {
        picker.dismissViewControllerAnimated(true) { () -> Void in
            
        }
    }
    
}
