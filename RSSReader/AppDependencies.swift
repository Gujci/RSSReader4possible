//
//  AppDependencies.swift
//  RSSReader
//
//  Created by Gujgiczer Máté on 22/12/15.
//  Copyright © 2015 Gujgiczer Máté. All rights reserved.
//

import UIKit

//MARK: - Login & session protocolls
@objc protocol AppSessionListener {
    
    optional func userDidLogIn(err: NSError?)
    optional func userDidLogOut(err: NSError?)
}

protocol SessionHandler {
    
    var isUserLoggedIn : Bool! { get }
    var userID : String! { get }
    var accessToken : String! { get }
    
    func logOut(err: NSError?)
    func logIn(err: NSError?)
    func addSessionListener(listener: AppSessionListener)
}

//MARK: - Navigation protocoll
protocol NavigationManager {
    
    func setMainWindow(window: UIWindow?)
    func startApplication(animated: Bool)
}

//MARK: - RSS data & protocols
struct RSSData {
    
    var title : String!
    var link : String!
    
    init(withTitle title: String, link: String) {
        self.title = title
        self.link = link
    }
}

@objc protocol RSSDataListener {
    
    optional func rssDataDidLoad(err: NSError?)
    optional func rssDataSelectedAt(index: Int)
}

protocol RSSDataProvider {
    
    var selectedDataIndex: Int! { get set}
    var rssData: Array<RSSData> { get }
    
    func loadData()
    func addDataListener(listener: RSSDataListener)
}

//MARK: - RSS subscription protocols
protocol SubscriptionListener {
    
    func subscriptionDataDidChange()
}

protocol RSSSubscriptionManager {
    
    var subscribedFeeds: Array<String> { get }
    var feedRecommendations: Array<String> { get }
    
    func addNewFeed(withUrl url: String)
    func removeFeed(withUrl url: String)
    func addSubscriptionListener(listener: SubscriptionListener)
}

//MARK: - Wire
class AppDependencies: NSObject {
    
    static let sharedInstance = AppDependencies()

    lazy var appSessionHandler : SessionHandler! = {
        return FacebookSessionHandler()
    }()
    lazy var appNavigationManager : NavigationManager! = {
       return BasicAppNavigationManager()
    }()
    lazy var appRSSDataProvider : RSSDataProvider! = {
        return RSSDataReader()
    }()
    lazy var appSubscriptionManager : RSSSubscriptionManager! = {
       return RSSSubscriptionDataManager()
    }()
}
