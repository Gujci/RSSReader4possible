//
//  RSSDataReader.swift
//  RSSReader
//
//  Created by Gujgiczer Máté on 22/12/15.
//  Copyright © 2015 Gujgiczer Máté. All rights reserved.
//

import UIKit

class RSSDataReader: NSObject, NSXMLParserDelegate, RSSDataProvider, SubscriptionListener {

    var selectedDataIndex: Int! {
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
        //TODO: - implement it
        dataListeners.forEach { (listener: RSSDataListener) -> () in
            listener.rssDataDidLoad?(nil)
        }
    }
    
    func addDataListener(listener: RSSDataListener) {
        dataListeners.append(listener)
    }
    
    //MARK: - subscription listener
    func subscriptionDataDidChange() {
        loadData()
    }
    
}
