//
//  RSSSubscriptionDataManager.swift
//  RSSReader
//
//  Created by Gujgiczer Máté on 23/12/15.
//  Copyright © 2015 Gujgiczer Máté. All rights reserved.
//

import UIKit

class RSSSubscriptionDataManager: NSObject, RSSSubscriptionManager {

    var subscribedFeeds: Array<String> {
        get {
            if let data = subscribedFeedURLData {
                return data
            }
            return [String]()
        }
    }
    var feedRecommendations: Array<String> {
        get {
            //TODO: -
            return ["sad","asd"]
        }
    }
    
    func addNewFeed(withUrl url: String) {
        var currentFeedList = subscribedFeedURLData
        currentFeedList?.append(url)
        subscribedFeedURLData = currentFeedList
    }
    
    private var subscribedFeedURLData: Array<String>? {
        get {
            if let id = NSUserDefaults.standardUserDefaults().objectForKey("\(AppSessionHandler.sharedInstance.userID).subscribedFeedURLData") as! [String]? {
                return id
            }
            else {
                return nil
            }
        }
        
        set (value) {
            NSUserDefaults.standardUserDefaults().setObject(value, forKey: "\(AppSessionHandler.sharedInstance.userID).subscribedFeedURLData")
            NSUserDefaults.standardUserDefaults().synchronize()
        }
    }
}
