//
//  SubscriptionsTableViewController.swift
//  RSSReader
//
//  Created by Gujgiczer Máté on 23/12/15.
//  Copyright © 2015 Gujgiczer Máté. All rights reserved.
//

import UIKit

class SubscriptionsTableViewController: UITableViewController, EmbededTableView, SubscriptionListener {

    let dataSource = AppDependencies.sharedInstance.appSubscriptionManager
    var contentHeight: CGFloat {
        get {
            return tableView.contentSize.height
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.tableFooterView = UIView(frame: CGRectZero)
        dataSource.addSubscriptionListener(self)
    }
    
    //MARK: - subscription listener
    func subscriptionDataDidChange() {
        tableView.reloadData()
    }

    // MARK: - Table view data source
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.subscribedFeeds.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("SubscriptionCellId", forIndexPath: indexPath) as! SubscriptionTableViewCell
        cell.data = dataSource.subscribedFeeds[indexPath.row]
        return cell
    }
}
