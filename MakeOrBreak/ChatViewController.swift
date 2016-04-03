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
        super.viewDidLoad()
        
        myRootRef.setValue(["key" : "value"])
        myRootRef.observeEventType(.Value, withBlock: { snapshot in
            print("\(snapshot.key) -> \(snapshot.value)")
        })
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}