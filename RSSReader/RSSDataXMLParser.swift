//
//  RSSDataXMLParser.swift
//  RSSReader
//
//  Created by Gujgiczer Máté on 23/12/15.
//  Copyright © 2015 Gujgiczer Máté. All rights reserved.
//

import UIKit

class RSSDataXMLParser: NSObject, NSXMLParserDelegate {
    
    static func startNewParser(withUrlString url: String!, done: ((NSError?, [RSSData]?) -> Void)?) {
        RSSDataXMLParser(withUrlString: url, done: done).start()
    }

    init(withUrlString url: String!, done: ((NSError?, [RSSData]?) -> Void)?) {
        super.init()
        
        realURL = NSURL(string: url)
        completionBlock = done
    }
    
    private var completionBlock : ((NSError?, [RSSData]?) -> Void)?
    private var realURL : NSURL!
    
    private var fetchedData : [RSSData]?
    private var elementName : String?
    private var currentTitle : String?
    private var currentLink : String?
    
    private func start() {
        fetchedData = [RSSData]()
        let parser = NSXMLParser(contentsOfURL: realURL)
        parser?.delegate = self
        parser?.shouldResolveExternalEntities = false
        parser?.parse()
    }
    
    //MARK: - XML Parser delegate methods
    func parser(parser: NSXMLParser, didStartElement elementName: String, namespaceURI: String?,
        qualifiedName qName: String?, attributes attributeDict: [String : String]) {
        self.elementName = elementName
        
        if elementName == "item" {
            self.currentTitle = ""
            self.currentLink = ""
        }
    }
    
    func parser(parser: NSXMLParser, foundCharacters string: String) {
        //FIXME: - do it in an appropriate way
        if string == "\n" {
            return
        }
        if elementName == "title" {
            currentTitle? += string
        }
        if elementName == "link" {
            currentLink? += string
        }
    }
    
    func parser(parser: NSXMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        if elementName == "item" {
            fetchedData?.append(RSSData(withTitle: currentTitle!, link: currentLink!))
        }
    }
    
    func parserDidEndDocument(parser: NSXMLParser) {
        completionBlock?(nil, fetchedData)
    }
    
}
