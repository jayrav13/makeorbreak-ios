//
//  RequestsViewController.swift
//  MakeOrBreak
//
//  Created by Jay Ravaliya on 4/2/16.
//  Copyright © 2016 JRav. All rights reserved.
//

import Foundation
import UIKit

class RequestsViewController : UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var tableView : UITableView!
    var refreshControl : UIRefreshControl!
    var addBarButtonItem : UIBarButtonItem!
    
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
        
        self.requestTypeSegmentedControl = UISegmentedControl()
        self.requestTypeSegmentedControl.addTarget(self, action: "segmentedControlPressed:", forControlEvents: UIControlEvents.ValueChanged)
        self.requestTypeSegmentedControl.frame = CGRect(x: Standard.screenWidth * 0.3, y: Standard.screenHeight * 0, width: Standard.screenWidth * 0.2, height: Standard.screenHeight * 0.2)
        self.navigationItem.titleView = self.requestTypeSegmentedControl
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("cell")
        cell = UITableViewCell(style: UITableViewCellStyle.Value1, reuseIdentifier: "cell")
        cell?.textLabel?.text = "Test"
        cell?.detailTextLabel?.text = "Test"
        return cell!
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
    }
    
    func addRequest(sender: UIButton) {
        var addVC : AddRequestViewController = AddRequestViewController()
        self.navigationController?.pushViewController(addVC, animated: true)
    }
    
    func refreshPulled(sender: UIRefreshControl) {
        sender.endRefreshing()
        // make api call
        print("Testing Refresh")
    }
    
}