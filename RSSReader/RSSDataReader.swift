//
//  RSSDataReader.swift
//  RSSReader
//
//  Created by Gujgiczer Máté on 22/12/15.
//  Copyright © 2015 Gujgiczer Máté. All rights reserved.
//

import UIKit

class RSSDataReader: NSObject, NSXMLParserDelegate, RSSDataProvider, SubscriptionListener {

    let rssFeedSource = AppDependencies.sharedInstance.appSubscriptionManager
    var selectedDataIndex: Int! = 0 {
        didSet {
            dataListeners.forEach { (listener: RSSDataListener) -> () in
                listener.rssDataSelectedAt?(selectedDataIndex)
            }
        }
    }
    var rssData: Array<RSSData> {
        get {
            if let data = loadedData {
                return data
            }
            return [RSSData]()
        }
    }
    
    private var loadedData: Array<RSSData>?
    private lazy var dataListeners : Array<RSSDataListener> = {
        return Array<RSSDataListener>()
    }()
    
    override init() {
        super.init()
        
        AppDependencies.sharedInstance.appSubscriptionManager.addSubscriptionListener(self)
    }
    
    func loadData() {
        loadedData = [RSSData]()
        //FIXME: - call the listeners in a normal way
        if rssFeedSource.subscribedFeeds.count > 0 {
            rssFeedSource.subscribedFeeds.forEach { (url) -> () in
                RSSDataXMLParser.startNewParser(withUrlString: url, done: { (err: NSError?, data: [RSSData]?) -> Void in
                    if let error = err {
                        self.dataListeners.forEach { (listener: RSSDataListener) -> () in
                            listener.rssDataDidLoad?(error)
                        }
                        return
                    }
                    self.loadedData?.appendContentsOf(data!)
                    self.dataListeners.forEach { (listener: RSSDataListener) -> () in
                        listener.rssDataDidLoad?(nil)
                    }
                })
            }
        }
        else {
            self.dataListeners.forEach { (listener: RSSDataListener) -> () in
                listener.rssDataDidLoad?(nil)
            }
        }
    }
    
    func addDataListener(listener: RSSDataListener) {
        dataListeners.append(listener)
    }
    
    //MARK: - SubscriptionListener
    func subscriptionDataDidChange() {
        loadData()
    }
    
}
