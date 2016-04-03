//
//  AddRequestViewController.swift
//  MakeOrBreak
//
//  Created by Jay Ravaliya on 4/2/16.
//  Copyright © 2016 JRav. All rights reserved.
//

import Foundation
import UIKit
import MaterialTextField


class AddRequestViewController : UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate, UITextFieldDelegate {
    
    var photoBarButtonItem : UIBarButtonItem!

    var imageView : UIImageView!
    var imagePicker : UIImagePickerController!
    
    var titleTextField : MFTextField!
    var descriptionTextView : UITextView!
    var priceTextField : MFTextField!
    
    var clarifyPending : Bool!
    
    var submitButton : UIButton!
    
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.whiteColor()
        self.title = "Add Request"
        
        self.navigationController?.navigationBar.topItem?.title = "Back"
        
        self.photoBarButtonItem = UIBarButtonItem(title: "Photo", style: UIBarButtonItemStyle.Plain, target: self, action: "photoButtonPressed:")
        self.navigationItem.rightBarButtonItem = self.photoBarButtonItem
        
        self.imagePicker = UIImagePickerController()
        self.imagePicker.delegate = self
        self.imagePicker.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        
        self.imageView = UIImageView(image: UIImage(named: "placeholder"))
        self.imageView.contentMode = UIViewContentMode.ScaleAspectFit
        self.imageView.frame = CGRect(x: Standard.screenWidth * 0.2, y: Standard.screenHeight * 0.55, width: Standard.screenWidth * 0.6, height: Standard.screenWidth * 0.3)
        // self.imageView.layer.borderWidth = 1
        self.imageView.layer.borderColor = UIColor.blackColor().CGColor
        self.view.addSubview(self.imageView)
        
        self.titleTextField = MFTextField()
        self.titleTextField.frame = CGRect(x: Standard.screenWidth * 0.2, y: Standard.screenHeight * 0.15, width: Standard.screenWidth * 0.6, height: Standard.screenHeight * 0.05)
        self.titleTextField.userInteractionEnabled = true
        self.titleTextField.delegate = self
        self.titleTextField.placeholder = "Title"
        self.titleTextField.textAlignment = NSTextAlignment.Center
        self.titleTextField.placeholderAnimatesOnFocus = true
        self.titleTextField.spellCheckingType = UITextSpellCheckingType.No
        self.view.addSubview(self.titleTextField)
        
        self.descriptionTextView = UITextView()
        self.descriptionTextView.frame = CGRect(x: Standard.screenWidth * 0.2, y: Standard.screenHeight * 0.35, width: Standard.screenWidth * 0.6, height: Standard.screenHeight * 0.15)
        self.descriptionTextView.layer.borderWidth = 0.5
        self.descriptionTextView.layer.borderColor = UIColor.blackColor().CGColor
        self.descriptionTextView.layer.cornerRadius = 5
        self.descriptionTextView.text = "Add details here..."
        self.view.addSubview(self.descriptionTextView)
        
        self.priceTextField = MFTextField()
        self.priceTextField.frame = CGRect(x: Standard.screenWidth * 0.2, y: Standard.screenHeight * 0.25, width: Standard.screenWidth * 0.6, height: Standard.screenHeight * 0.05)
        self.priceTextField.userInteractionEnabled = true
        self.priceTextField.delegate = self
        self.priceTextField.placeholder = "Price"
        self.priceTextField.textAlignment = NSTextAlignment.Center
        self.priceTextField.placeholderAnimatesOnFocus = true
        self.priceTextField.keyboardType = UIKeyboardType.NumberPad
        self.view.addSubview(self.priceTextField)

        self.submitButton = UIButton(type: UIButtonType.System)
        self.submitButton.setTitle("Submit", forState: UIControlState.Normal)
        self.submitButton.backgroundColor = UIColor.blackColor()
        self.submitButton.setTitleColor(UIColor.yellowColor(), forState: UIControlState.Normal)
        self.submitButton.frame = CGRect(x: Standard.screenWidth * 0.25, y: Standard.screenHeight * 0.75, width: Standard.screenWidth * 0.5, height: Standard.screenHeight * 0.05)
        self.submitButton.addTarget(self, action: "submitRequestPressed:", forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(self.submitButton)
        
        self.clarifyPending = false
        
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
            self.imageView.image = image
            // Clarifai request
            
        }
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func base64encode(image: UIImage) -> String {
        return UIImagePNGRepresentation(image)!.base64EncodedStringWithOptions(.Encoding64CharacterLineLength)
    }
    
    func base64decode(image : String) -> UIImage {
        return UIImage(data: NSData(base64EncodedString: image, options: NSDataBase64DecodingOptions.IgnoreUnknownCharacters)!)!
    }
    
    func submitRequestPressed(sender: UIButton) {
        if(self.clarifyPending == true) {
            self.presentViewController(Elements.createAlert("Error", message: "Image request in process - wait a few seconds and try again!"), animated: true, completion: { () -> Void in
                
            })
        }
        else {
            API.addRequest(self.titleTextField.text!, description: self.descriptionTextView.text!, image64: base64encode(self.imageView.image!), price: self.priceTextField.text!, completion: { (success, data) -> Void in
                
                if(success) {
                    self.navigationController?.popToRootViewControllerAnimated(true)
                }
                else {
                    self.presentViewController(Elements.createAlert("Error", message: "Unable to post this request at this time - please try again!"), animated: true, completion: { () -> Void in
                        
                    })
                }
            })
        }
    }
    
}
