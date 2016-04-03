//
//  RequestsViewController.swift
//  MakeOrBreak
//
//  Created by Jay Ravaliya on 4/2/16.
//  Copyright © 2016 JRav. All rights reserved.
//

import Foundation
import UIKit
import SwiftyJSON

class RequestsViewController : UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var tableView : UITableView!
    var refreshControl : UIRefreshControl!
    var addBarButtonItem : UIBarButtonItem!

    var data : JSON!
    
    var requestTypeSegmentedControl : UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.whiteColor()
        self.navigationController?.navigationBar.barTintColor = UIColor.blackColor()
        self.navigationController?.navigationBar.titleTextAttributes = [
            NSForegroundColorAttributeName : UIColor.yellowColor()
        ]
        UIApplication.sharedApplication().statusBarStyle = UIStatusBarStyle.LightContent
        
        self.title = "Requests Near You"
        
        self.tableView = UITableView()
        self.tableView.frame = self.view.frame
        self.tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.view.addSubview(self.tableView)
        
        self.refreshControl = UIRefreshControl()
        self.refreshControl.addTarget(self, action: "refreshPulled:", forControlEvents: UIControlEvents.ValueChanged)
        self.tableView.addSubview(self.refreshControl)
        
        self.addBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Add, target: self, action: "addRequest:")
        self.addBarButtonItem.tintColor = UIColor.yellowColor()
        self.navigationItem.rightBarButtonItem = self.addBarButtonItem
        
        self.requestTypeSegmentedControl = UISegmentedControl(items: ["All", "My", "Claimed"])
        self.requestTypeSegmentedControl.addTarget(self, action: "segmentedControlPressed:", forControlEvents: UIControlEvents.ValueChanged)
        self.requestTypeSegmentedControl.frame = CGRect(x: Standard.screenWidth * 0.3, y: Standard.screenHeight * 0, width: Standard.screenWidth * 0.2, height: 28)
        self.requestTypeSegmentedControl.backgroundColor = UIColor.yellowColor()
        self.requestTypeSegmentedControl.layer.cornerRadius = 5;
        self.requestTypeSegmentedControl.setTitleTextAttributes([NSForegroundColorAttributeName : UIColor.blackColor()], forState: UIControlState.Normal)
        self.requestTypeSegmentedControl.tintColor = UIColor.blackColor()
        self.requestTypeSegmentedControl.selectedSegmentIndex = 0
        self.navigationItem.titleView = self.requestTypeSegmentedControl
        
        self.data = []
        self.refreshData(self.requestTypeSegmentedControl.selectedSegmentIndex)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        self.refreshData(self.requestTypeSegmentedControl.selectedSegmentIndex)
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(true)
        self.refreshData(self.requestTypeSegmentedControl.selectedSegmentIndex)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("cell")
        cell = UITableViewCell(style: UITableViewCellStyle.Value1, reuseIdentifier: "cell")
        cell?.textLabel?.text = self.data["requests"][indexPath.row]["title"].stringValue
        cell?.detailTextLabel?.text = "$ " + String(self.data["requests"][indexPath.row]["price"].intValue)
        return cell!
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        var vrvc : ViewRequestViewController = ViewRequestViewController()
        vrvc.data = self.data["requests"][indexPath.row]
        vrvc.type = self.requestTypeSegmentedControl.selectedSegmentIndex
        self.navigationController?.pushViewController(vrvc, animated: true)
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.data["requests"].count
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
    }
    
    func addRequest(sender: UIButton) {
        var addVC : AddRequestViewController = AddRequestViewController()
        self.navigationController?.pushViewController(addVC, animated: true)
    }
    
    func segmentedControlPressed(sender : UISegmentedControl) {
        self.refreshData(self.requestTypeSegmentedControl.selectedSegmentIndex)
    }
    
    func refreshPulled(sender: UIRefreshControl) {
        sender.endRefreshing()
        self.refreshData(self.requestTypeSegmentedControl.selectedSegmentIndex)
        // make api call
        print("Testing Refresh")
    }
    
    func refreshData(index : Int) {
        if(index == 0) {
            API.getUserRequests { (success, data) -> Void in
                if(success) {
                    self.data = data
                    self.tableView.reloadData()
                }
                else {
                    self.presentViewController(Elements.createAlert("Error", message: "Unable to get requests at this time. Please try again!"), animated: true, completion: { () -> Void in
                        
                    })
                }
            }
        }
        else if(index == 1) {
            API.getUserMadeRequests({ (success, data) -> Void in
                if(success) {
                    self.data = data
                    self.tableView.reloadData()
                }
                else {
                    self.presentViewController(Elements.createAlert("Error", message: "Unable to get requests at this time. Please try again!"), animated: true, completion: { () -> Void in
                        
                    })
                }
            })
        }
        else {
            API.getUserClaimed({ (success, data) -> Void in
                if(success) {
                    self.data = data
                    self.tableView.reloadData()
                }
                else {
                    self.presentViewController(Elements.createAlert("Error", message: "Unable to get requests at this time. Please try again!"), animated: true, completion: { () -> Void in
                        
                    })
                }
            })
        }
    }
    
}