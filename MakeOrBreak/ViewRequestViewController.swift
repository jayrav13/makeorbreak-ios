//
//  ViewRequestViewController.swift
//  MakeOrBreak
//
//  Created by Jay Ravaliya on 4/3/16.
//  Copyright © 2016 JRav. All rights reserved.
//

import Foundation
import UIKit
import SwiftyJSON
import Firebase

class ViewRequestViewController : UIViewController {
    
    var data : JSON!
    var type : Int!
    
    var titleLabel : UILabel!
    var detailsLabel : UILabel!
    var priceLabel : UILabel!
    
    var actionButton : UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.whiteColor()
        
        self.titleLabel = UILabel()
        self.titleLabel.text = self.data["title"].stringValue
        self.titleLabel.textAlignment = NSTextAlignment.Center
        self.titleLabel.frame = CGRect(x: Standard.screenWidth * 0.2, y: Standard.screenWidth * 0.2, width: Standard.screenWidth * 0.6, height: Standard.screenHeight * 0.1)
        self.view.addSubview(self.titleLabel)
        
        self.detailsLabel = UILabel()
        self.detailsLabel.text = self.data["description"].stringValue
        self.detailsLabel.textAlignment = NSTextAlignment.Center
        self.detailsLabel.frame = CGRect(x: Standard.screenWidth * 0.2, y: Standard.screenWidth * 0.3, width: Standard.screenWidth * 0.6, height: Standard.screenHeight * 0.1)
        self.view.addSubview(self.detailsLabel)
        
        self.priceLabel = UILabel()
        self.priceLabel.text = self.data["price"].stringValue
        self.priceLabel.textAlignment = NSTextAlignment.Center
        self.priceLabel.frame = CGRect(x: Standard.screenWidth * 0.2, y: Standard.screenWidth * 0.4, width: Standard.screenWidth * 0.6, height: Standard.screenHeight * 0.1)
        self.view.addSubview(self.priceLabel)
        
        self.actionButton = UIButton(type: UIButtonType.System)
        if (self.type == 0) {
            self.actionButton.setTitle("Claim", forState: UIControlState.Normal)
        }
        else if (self.type == 1) {
            self.actionButton.setTitle("Complete", forState: UIControlState.Normal)
        }
        else {
            self.actionButton.setTitle("Cancel", forState: UIControlState.Normal)
        }
        
        self.actionButton.addTarget(self, action: "actionButtonPressed:", forControlEvents: UIControlEvents.TouchUpInside)
        self.actionButton.frame = CGRect(x: Standard.screenWidth * 0.2, y: Standard.screenWidth * 0.6, width: Standard.screenWidth * 0.6, height: Standard.screenHeight * 0.1)
        self.view.addSubview(self.actionButton)
        
        print(data)
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func actionButtonPressed(sender: UIButton) {
        
        if (self.type == 0) {
            API.claimRequest(self.data["id"].intValue) { (success, data) -> Void in
                if(success) {
                    self.navigationController?.popToRootViewControllerAnimated(true)
                }
                else {
                    Elements.createAlert("Error", message: "Sorry - this claim could not be processed")
                }
            }
        }
        else if (self.type == 1) {
            
        }
        
    }
    
    
}

