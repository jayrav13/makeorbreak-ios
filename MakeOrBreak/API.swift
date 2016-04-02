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
    
    static let base_url : String = ""
    
    static func isValid(username : String, completion : (success : Bool, data : JSON) -> Void) -> Void {
        
        let parameters : [String : AnyObject] = [
            "username" : username
        ]
        
        completion(success: false, data: nil)
        
        /*Alamofire.request(Method.POST, base_url + "...", parameters: parameters, encoding: ParameterEncoding.URL, headers: nil).responseJSON { (response) -> Void in
            
            if(response.response?.statusCode == 200) {
                completion(success: true, data: JSON(response.result.value!))
            }
            else {
                completion(success: false, data: nil)
            }
            
            
        }*/
        
    }
    
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

class Elements {
    
    /* Create a simple alert with message */
    static func createAlert(title: String, message: String) -> UIAlertController {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Cancel, handler: { (action) -> Void in

        }))
        return alert
        
    }
    
}