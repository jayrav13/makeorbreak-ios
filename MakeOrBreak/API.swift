//
//  API.swift
//  MakeOrBreak
//
//  Created by Jay Ravaliya on 4/2/16.
//  Copyright © 2016 JRav. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import Foundation

class API {
    
    let base_url : String = ""
    
}

class NSAPI {
    
    static func getUsername() -> String {
        return String(NSUserDefaults.standardUserDefaults().objectForKey("username"))
    }
    
    static func setUsername(username : String) {
        NSUserDefaults.standardUserDefaults().setObject(username, forKey: "username")
    }
    
    static func hasUsername() -> Bool {
        return NSUserDefaults.standardUserDefaults().objectForKey("username") == nil ? false : true
    }
    
}

class Standard {
    static let screenWidth = UIScreen.mainScreen().bounds.width
    static let screenHeight = UIScreen.mainScreen().bounds.height
}