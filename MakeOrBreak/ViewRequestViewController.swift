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

class ViewRequestViewController : UIViewController, LGChatControllerDelegate {
    
    var data : JSON!
    var type : Int!
    
    var titleLabel : UILabel!
    var detailsLabel : UILabel!
    var priceLabel : UILabel!
    
    var actionButton : UIButton!
    
    var chatButton : UIBarButtonItem!
    
    var firebase: Firebase? = Firebase(url: "https://makeorbreak.firebaseIO.com")
    
    var chatController : LGChatController!
    
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
        
        if(data["fixer_name"].stringValue != data["breaker_name"].stringValue) {
            self.chatButton = UIBarButtonItem(title: "Chat", style: UIBarButtonItemStyle.Plain, target: self, action: "launchChatController:")
            self.navigationItem.rightBarButtonItem = self.chatButton
        }
        
        
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
    
    func launchChatController(sender: UIButton) {
        self.chatController = LGChatController()
        chatController.title = "Chat with ..."
        let helloWorld = LGChatMessage(content: "Hello World!", sentBy: .User)
        chatController.messages = [helloWorld]
        chatController.delegate = self
        self.navigationController!.pushViewController(chatController, animated: true)
    
        firebase!.observeEventType(.Value, withBlock: { snapshot in
            var str : String? = snapshot.value["to"] as? String
            print(str!)
            if(str! == NSAPI.getUsername()) {
                self.addMessage("\(snapshot.value["message"])", user: "\(snapshot.value["from"])")
            }
        })
    }

    func chatController(chatController: LGChatController, didAddNewMessage message: LGChatMessage) {
        print("Did Add Message: \(message.content)")
        let usernames = self.getUsernames()
        self.firebase!.setValue([
            "from" : usernames[0],
            "to" : usernames[1],
            "message" : message.content
        ])
    }
    
    func shouldChatController(chatController: LGChatController, addMessage message: LGChatMessage) -> Bool {
        return true
    }
    
    func addMessage(message : String, user : String) {
        
        var helloworld : LGChatMessage!
        
        if(NSAPI.getUserId() == self.data["user_id"].intValue) {
            if(NSAPI.getUsername() == self.data["breaker_name"].stringValue) {
                // me
                helloworld = LGChatMessage(content: message, sentBy: LGChatMessage.SentBy.User)
            }
            else {
                // other
                helloworld = LGChatMessage(content: message, sentBy: LGChatMessage.SentBy.Opponent)
            }
        }
        else {
            if(NSAPI.getUsername() == self.data["fixer_name"].stringValue) {
                // me
                helloworld = LGChatMessage(content: message, sentBy: LGChatMessage.SentBy.User)
            }
            else {
                // other
                helloworld = LGChatMessage(content: message, sentBy: LGChatMessage.SentBy.Opponent)
            }
        }
        
        self.chatController.addNewMessage(helloworld)
    }
    
    func getUsernames() -> [String] {
        var usernames : [String] = ["",""]
        if(NSAPI.getUserId() == self.data["user_id"].intValue) {
            if(NSAPI.getUsername() == self.data["breaker_name"].stringValue) {
                // me
                usernames[0] = self.data["breaker_name"].stringValue
                usernames[1] = self.data["fixer_name"].stringValue
            }
            else {
                // other
                usernames[0] = self.data["fixer_name"].stringValue
                usernames[1] = self.data["breaker_name"].stringValue
            }
        }
        else {
            if(NSAPI.getUsername() == self.data["fixer_name"].stringValue) {
                // me
                usernames[0] = self.data["fixer_name"].stringValue
                usernames[1] = self.data["breaker_name"].stringValue
            }
            else {
                // other
                usernames[0] = self.data["breaker_name"].stringValue
                usernames[1] = self.data["fixer_name"].stringValue
            }
        }
        return usernames;
    }
    
}

