//
//  IntroViewController.swift
//  MakeOrBreak
//
//  Created by Jay Ravaliya on 4/2/16.
//  Copyright © 2016 JRav. All rights reserved.
//

import Foundation
import UIKit

class IntroViewController : UIViewController, UITextFieldDelegate {
    
    var textField : UITextField!
    var loginButton : UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.whiteColor()
        
        self.title = "Make 0r Break"
        
        self.textField = UITextField()
        self.textField.frame = CGRect(x: Standard.screenWidth * 0.25, y: Standard.screenHeight * 0.2, width: Standard.screenWidth * 0.5, height: Standard.screenHeight * 0.05)
        self.textField.borderStyle = UITextBorderStyle.Bezel
        self.textField.layer.cornerRadius = 5
        self.textField.userInteractionEnabled = true
        self.textField.delegate = self
        self.textField.spellCheckingType = UITextSpellCheckingType.No
        self.view.addSubview(self.textField)
        
        self.loginButton = UIBarButtonItem(title: "Login", style: UIBarButtonItemStyle.Plain, target: self, action: "login:")
        self.navigationItem.rightBarButtonItem = self.loginButton
        
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
        print("Made it!")
    }
    
}