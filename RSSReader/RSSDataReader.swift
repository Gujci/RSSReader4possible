//
//  RSSDataReader.swift
//  RSSReader
//
//  Created by Gujgiczer Máté on 22/12/15.
//  Copyright © 2015 Gujgiczer Máté. All rights reserved.
//

import UIKit

class RSSDataReader: NSObject, NSXMLParserDelegate, RSSDataProvider {

    var rssData: Array<RSSData> {
        get {
            if let data = loadedData {
                return data
            }
            return [RSSData]()
        }
    }
    
    private var loadedData: Array<RSSData>?
    
    func loadData(done: ((NSError?) -> Void)) {
        //TODO: - implement it
    }
}
