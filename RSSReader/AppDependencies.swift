//
//  AppDependencies.swift
//  RSSReader
//
//  Created by Gujgiczer Máté on 22/12/15.
//  Copyright © 2015 Gujgiczer Máté. All rights reserved.
//

import UIKit

struct RSSData {
    
    var title : String!
    var link : String!
    
    
}

protocol RSSDataProvider {
    
    var rssData: Array<RSSData> { get }

    func loadData(done: ((NSError?) -> Void))
}

protocol RSSSubscriptionManager {
    
    var subscribedFeeds: Array<String> { get }
    var feedRecommendations: Array<String> { get }
    
    func addNewFeed(withUrl url: String)
}

class AppDependencies: NSObject {
    
    static let sharedInstance = AppDependencies()

    var appRSSDataProvider : RSSDataProvider!
    var appSubscriptionManager : RSSSubscriptionManager!
    
    override init() {
        super.init()
        
        appRSSDataProvider = RSSDataReader()
        appSubscriptionManager = RSSSubscriptionDataManager()
    }
}
