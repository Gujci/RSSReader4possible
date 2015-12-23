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
            return [feedRecommendations[0]]
        }
    }
    var feedRecommendations: Array<String> {
        get {
            var suggestions = [
                "http://images.apple.com/main/rss/hotnews/hotnews.rss",
                "TEST",
                "TEST2"
            ]
            subscribedFeedURLData?.forEach({ (url) -> () in
                suggestions.removeObject(url)
            })
            return suggestions
        }
    }
    
    private lazy var subscriptionListeners : Array<SubscriptionListener> = {
        return Array<SubscriptionListener>()
    }()
    
    func addNewFeed(withUrl url: String) {
        var currentFeedList = subscribedFeedURLData
        if currentFeedList == nil {
            currentFeedList = [String]()
        }
        currentFeedList?.append(url)
        subscribedFeedURLData = currentFeedList
        subscriptionListeners.forEach { (listener: SubscriptionListener) -> () in
            listener.subscriptionDataDidChange()
        }
    }
    
    func removeFeed(withUrl url: String) {
        var currentFeedList = subscribedFeedURLData
        currentFeedList?.removeObject(url)
        subscribedFeedURLData = currentFeedList
        subscriptionListeners.forEach { (listener: SubscriptionListener) -> () in
            listener.subscriptionDataDidChange()
        }
    }
    
    func addSubscriptionListener(listener: SubscriptionListener) {
        subscriptionListeners.append(listener)
    }
    
    private var subscribedFeedURLData: Array<String>? {
        get {
            if let id = NSUserDefaults.standardUserDefaults().objectForKey(
                "\(AppDependencies.sharedInstance.appSessionHandler.userID).subscribedFeedURLData") as! [String]? {
                return id
            }
            else {
                return nil
            }
        }
        
        set (value) {
            NSUserDefaults.standardUserDefaults().setObject(value,
                forKey: "\(AppDependencies.sharedInstance.appSessionHandler.userID).subscribedFeedURLData")
            NSUserDefaults.standardUserDefaults().synchronize()
        }
    }
}
