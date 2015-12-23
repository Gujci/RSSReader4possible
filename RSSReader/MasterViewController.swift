//
//  MasterViewController.swift
//  RSSReader
//
//  Created by Gujgiczer Máté on 21/12/15.
//  Copyright © 2015 Gujgiczer Máté. All rights reserved.
//

import UIKit

class MasterViewController: UITableViewController, RSSDataListener {
    
    private let dataProvider : RSSDataProvider = AppDependencies.sharedInstance.appRSSDataProvider
    
    @IBOutlet weak var profileButton: UIBarButtonItem!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.tableFooterView = UIView(frame: CGRectZero)
        dataProvider.addDataListener(self)
        dataProvider.loadData()
    }

    override func viewWillAppear(animated: Bool) {
        self.clearsSelectionOnViewWillAppear = self.splitViewController!.collapsed
        super.viewWillAppear(animated)
    }
    
    // MARK: - RSSDataListener 
    func rssDataDidLoad(err: NSError?) {
        if let _ = err {
            return
        }
        tableView.reloadData()
    }
    
    
    // MARK: - Table View
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataProvider.rssData.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("feedCell", forIndexPath: indexPath)
        //TODO: - setup with data
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        //TODO: - implement it
    }
    
    //MARK: - Navigation
    @IBAction func closedProfile(segue:UIStoryboardSegue) {
    }
}

