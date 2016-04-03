//
//  ChatViewController.swift
//  MakeOrBreak
//
//  Created by Jay Ravaliya on 4/3/16.
//  Copyright © 2016 JRav. All rights reserved.
//

import Foundation
import Firebase

class ChatViewController : UIViewController, LGChatControllerDelegate {
    
    var myRootRef = Firebase(url: "https://makeorbreak.firebaseio.com")
    
    override func viewDidLoad() {
        self.launchChatController()
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.whiteColor()
    }
    
    func launchChatController() {
        let chatController = LGChatController()
        chatController.title = "Chat with ..."
        let helloWorld = LGChatMessage(content: "Hello World!", sentBy: .User)
        chatController.messages = [helloWorld]
        chatController.delegate = self
        self.navigationController!.pushViewController(chatController, animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func chatController(chatController: LGChatController, didAddNewMessage message: LGChatMessage) {
        print("Did Add Message: \(message.content)")
    }
    
    func shouldChatController(chatController: LGChatController, addMessage message: LGChatMessage) -> Bool {
        /*
        Use this space to prevent sending a message, or to alter a message.  For example, you might want to hold a message until its successfully uploaded to a server.
        */
        return true
    }
    
    

}