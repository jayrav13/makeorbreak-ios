//
//  TagsViewController.swift
//  MakeOrBreak
//
//  Created by Jay Ravaliya on 4/3/16.
//  Copyright © 2016 JRav. All rights reserved.
//

import Foundation
import UIKit
import SwiftyJSON

class TagsViewController : UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var tableView : UITableView!
    
    var addBarButtonItem : UIBarButtonItem!
    var backBarButtonItem : UIBarButtonItem!
    
    var data : JSON!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.tableView = UITableView()
        self.tableView.frame = self.view.frame
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
        self.view.addSubview(self.tableView)
        
        self.addBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Add, target: self, action: "addTagsPressed:")
        self.addBarButtonItem.tintColor = UIColor.yellowColor()
        self.navigationItem.rightBarButtonItem = self.addBarButtonItem
        
        self.navigationController?.navigationBar.topItem?.title = "Back"
        
        self.data = []
        self.refreshData()

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "cell")
        cell.textLabel?.text = self.data["tags"][indexPath.row].stringValue
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.data["tags"].count
    }
    
    func refreshData() {
        API.getTags { (success, data) -> Void in
            self.data = data
            self.tableView.reloadData()
        }
    }
    
    func addTagsPressed(sender: UIButton) {
        //1. Create the alert controller.
        var alert = UIAlertController(title: "Some Title", message: "Enter a text", preferredStyle: .Alert)
        
        //2. Add the text field. You can configure it however you need.
        alert.addTextFieldWithConfigurationHandler({ (textField) -> Void in
            textField.text = "Some default text."
        })
        
        //3. Grab the value from the text field, and print it when the user clicks OK.
        alert.addAction(UIAlertAction(title: "OK", style: .Default, handler: { (action) -> Void in
            let textField = alert.textFields![0] as UITextField
            
            API.addTags(textField.text!, completion: { (success, data) -> Void in
                if(success) {
                    self.refreshData()
                }
                else {
                    self.presentViewController(Elements.createAlert("Error", message: "Tag not added - please try again!"), animated: true, completion: { () -> Void in
                        
                    })
                }
            })
        }))
        
        // 4. Present the alert.
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
}