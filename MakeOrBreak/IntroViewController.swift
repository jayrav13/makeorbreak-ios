//
//  IntroViewController.swift
//  MakeOrBreak
//
//  Created by Jay Ravaliya on 4/2/16.
//  Copyright © 2016 JRav. All rights reserved.
//

import Foundation
import UIKit
import MaterialTextField
import CoreLocation

class IntroViewController : UIViewController, UITextFieldDelegate, CLLocationManagerDelegate {
    
    var usernameTextField : MFTextField!
    var phoneNumberTextField : MFTextField!
    var logoImageView : UIImageView!
    var locationManager : CLLocationManager!
    
    var loginButton : UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.whiteColor()
        
        self.title = "MakeOrBreak"
        
        self.usernameTextField = MFTextField()
        self.usernameTextField.frame = CGRect(x: Standard.screenWidth * 0.15, y: Standard.screenHeight * 0.40, width: Standard.screenWidth * 0.70, height: Standard.screenHeight * 0.05)
        self.usernameTextField.userInteractionEnabled = true
        self.usernameTextField.delegate = self
        self.usernameTextField.placeholder = "Username"
        self.usernameTextField.textAlignment = NSTextAlignment.Center
        self.usernameTextField.placeholderAnimatesOnFocus = true
        self.usernameTextField.spellCheckingType = UITextSpellCheckingType.No
        self.view.addSubview(self.usernameTextField)
        
        self.phoneNumberTextField = MFTextField()
        self.phoneNumberTextField.frame = CGRect(x: Standard.screenWidth * 0.15, y: Standard.screenHeight * 0.5, width: Standard.screenWidth * 0.70, height: Standard.screenHeight * 0.05)
        self.phoneNumberTextField.placeholder = "Phone Number"
        self.phoneNumberTextField.textAlignment = NSTextAlignment.Center
        self.phoneNumberTextField.keyboardType = UIKeyboardType.NumberPad
        self.phoneNumberTextField.placeholderAnimatesOnFocus = true
        self.phoneNumberTextField.userInteractionEnabled = true
        self.phoneNumberTextField.delegate = self
        self.phoneNumberTextField.spellCheckingType = UITextSpellCheckingType.No
        self.view.addSubview(self.phoneNumberTextField)
        
        self.loginButton = UIButton(type: UIButtonType.System)
        self.loginButton.setTitle("LOG IN", forState: UIControlState.Normal)
        self.loginButton.addTarget(self, action: "login:", forControlEvents: UIControlEvents.TouchUpInside)
        self.loginButton.frame = CGRect(x: Standard.screenWidth * 0.15, y: Standard.screenHeight * 0.65, width: Standard.screenWidth * 0.70, height: Standard.screenHeight * 0.05)
        self.loginButton.titleLabel?.textAlignment = NSTextAlignment.Center
        self.loginButton.backgroundColor = UIColor.blackColor()
        self.loginButton.setTitleColor(UIColor.yellowColor(), forState: UIControlState.Normal)
        self.view.addSubview(self.loginButton)
        
        self.logoImageView = UIImageView(image: UIImage(named: "mob-image"))
        self.logoImageView.frame = CGRect(x: Standard.screenWidth * 0.25, y: Standard.screenHeight * 0.1, width: Standard.screenWidth * 0.5, height: Standard.screenWidth * 0.5)
        self.view.addSubview(self.logoImageView)
        
        // Location Setup
        self.locationManager = CLLocationManager()
        self.locationManager.delegate = self
        self.locationManager.requestAlwaysAuthorization()
        self.locationManager.requestWhenInUseAuthorization()
        self.locationManager.startUpdatingLocation()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func textFieldDidBeginEditing(textField: UITextField) {
        // print("Begin!")
    }
    
    func login(sender: UIButton) {
        API.signin(self.usernameTextField.text!, phone_number: self.phoneNumberTextField.text!) { (success, data) -> Void in
            if(success) {
                NSAPI.setUserId(data["id"].intValue)
                NSAPI.setUsername(data["username"].stringValue)
                NSAPI.setToken(data["token"].stringValue)
                
                print(NSAPI.getToken())
                print(NSAPI.getUserId())
                print(NSAPI.getUsername())
                
                self.presentViewController(UINavigationController(rootViewController: RequestsViewController()), animated: true, completion: { () -> Void in
                })
            }
            else {
                self.presentViewController(Elements.createAlert("Error", message: "Username unavailable - try another one!"), animated: true, completion: { () -> Void in
                    
                })
                
                
            }
        }
    }
    
}