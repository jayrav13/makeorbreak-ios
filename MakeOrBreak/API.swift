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
import CoreLocation

class API {
    
    static let base_url : String = "http://b6e99723.ngrok.io"
    
    static func signin(username : String, phone_number : String, completion : (success : Bool, data : JSON) -> Void) -> Void {
        
        let parameters : [String : AnyObject] = [
            "username" : username,
            "lat" : UserLocation.getLatitude(),
            "long" : UserLocation.getLongitude(),
            "phone_number" : phone_number,
            "radius" : 15,
            "device_id" : (UIDevice.currentDevice().identifierForVendor?.UUIDString)!
        ]
        
        Alamofire.request(Method.POST, base_url + "/signin", parameters: parameters, encoding: ParameterEncoding.JSON, headers: nil).responseJSON { (response) -> Void in
            
            if(response.response?.statusCode == 200) {
                completion(success: true, data: JSON(response.result.value!))
            }
            else {
                completion(success: false, data: nil)
            }
        }
    }
    
    static func updateCoordinates(completion : (success : Bool, data : JSON) -> Void) -> Void {
        
        let parameters : [String : AnyObject] = [
            "lat" : UserLocation.getLatitude(),
            "long" : UserLocation.getLongitude(),
            "user_id" : NSAPI.getUserId()
        ]
        
        Alamofire.request(Method.POST, base_url + "/update_coordinates", parameters: parameters, encoding: ParameterEncoding.JSON, headers: nil).responseJSON { (response) -> Void in
            
            if(response.response?.statusCode == 200) {
                completion(success: true, data: JSON(response.result.value!))
            }
            else {
                completion(success: false, data: nil)
            }
        }
    }
    
    static func addRequest(title : String, description : String, image64 : String, completion : (success : Bool, data : JSON) -> Void) -> Void {
        
        let parameters : [String : AnyObject] = [
            "user_id" : NSAPI.getUserId(),
            "request" : [
                "title" : title,
                "description" : description,
                "lat" : UserLocation.getLatitude(),
                "long" : UserLocation.getLongitude(),
                "image64" : image64
            ]
        ]
        
        Alamofire.request(Method.POST, base_url + "/requests", parameters: parameters, encoding: ParameterEncoding.JSON, headers: nil).responseJSON { (response) -> Void in
            
            if(response.response?.statusCode == 200) {
                completion(success: true, data: JSON(response.result.value!))
            }
            else {
                completion(success: false, data: nil)
            }
        }
    }
}

class NSAPI {
    
    static func getUsername() -> String {
        return String(NSUserDefaults.standardUserDefaults().objectForKey("username"))
    }
    
    static func setUsername(username : String) {
        NSUserDefaults.standardUserDefaults().setObject(username, forKey: "username")
    }
    
    static func getUserId() -> Int {
        return NSUserDefaults.standardUserDefaults().integerForKey("user_id")
    }
    
    static func setUserId(user_id : Int) {
        NSUserDefaults.standardUserDefaults().setInteger(user_id, forKey: "user_id")
    }
    
    static func setToken(token : String) {
        NSUserDefaults.standardUserDefaults().setObject(token, forKey: "token")
    }
    
    static func getToken() -> String {
        return String(NSUserDefaults.standardUserDefaults().objectForKey("token"))
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

class UserLocation {
    
    static let locationManager : CLLocationManager = CLLocationManager()
    static func getLatitude() -> CLLocationDegrees {
        return (locationManager.location?.coordinate.latitude)!
    }
    static func getLongitude() -> CLLocationDegrees {
        return (locationManager.location?.coordinate.longitude)!
    }
    
}