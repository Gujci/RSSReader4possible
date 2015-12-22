//
//  RSSDataReader.swift
//  RSSReader
//
//  Created by Gujgiczer Máté on 22/12/15.
//  Copyright © 2015 Gujgiczer Máté. All rights reserved.
//

import UIKit

class RSSDataReader: NSObject, RSSDataProvider {

    var rssData: Array<NSObject> {
        get {
            //TODO: -
            return Array<NSObject>()
        }
    }
    
    func addNewFeed(withUrl url: String, done: ((NSError?) -> Void)) {
        
    }
    
    func loadData(done: ((NSError?) -> Void)) {
        
    }
}
