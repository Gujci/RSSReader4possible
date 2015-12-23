//
//  SuggestionsTableViewController.swift
//  RSSReader
//
//  Created by Gujgiczer Máté on 23/12/15.
//  Copyright © 2015 Gujgiczer Máté. All rights reserved.
//

import UIKit

class SuggestionsTableViewController: UITableViewController, EmbededTableView, SubscriptionListener {

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
        return dataSource.feedRecommendations.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("RecomendationCellId", forIndexPath: indexPath) as! SuggestionTableViewCell
        cell.data = dataSource.feedRecommendations[indexPath.row]
        return cell
    }
}
