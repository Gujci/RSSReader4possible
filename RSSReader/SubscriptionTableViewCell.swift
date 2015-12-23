//
//  SubscriptionTableViewCell.swift
//  RSSReader
//
//  Created by Gujgiczer Máté on 23/12/15.
//  Copyright © 2015 Gujgiczer Máté. All rights reserved.
//

import UIKit

class SubscriptionTableViewCell: UITableViewCell {

    @IBOutlet weak var channelTitle: UILabel!
    
    var data : String! {
        didSet {
            channelTitle.text = data
        }
    }
    
    //MARK: - Actions
    @IBAction func deleteButtonPressed(sender: AnyObject) {
        AppDependencies.sharedInstance.appSubscriptionManager.removeFeed(withUrl: data)
    }

}
