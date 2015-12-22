//
//  AppDependencies.swift
//  RSSReader
//
//  Created by Gujgiczer Máté on 22/12/15.
//  Copyright © 2015 Gujgiczer Máté. All rights reserved.
//

import UIKit

protocol RSSDataProvider {
    
    var rssData: Array<NSObject> { get }
    
    func addNewFeed(withUrl url: String, done: ((NSError?) -> Void))
    func loadData(done: ((NSError?) -> Void))
}

class AppDependencies: NSObject {
    
    static let sharedInstance = AppDependencies()

    var appRSSDataProvider : RSSDataProvider!
    
    override init() {
        super.init()
        
        appRSSDataProvider = RSSDataReader()
    }
}
