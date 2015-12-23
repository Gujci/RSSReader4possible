//
//  FacebookSessionHandler.swift
//  RSSReader
//
//  Created by Gujgiczer Máté on 22/12/15.
//  Copyright © 2015 Gujgiczer Máté. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import FBSDKLoginKit


class FacebookSessionHandler: NSObject, SessionHandler {
    
    var isUserLoggedIn : Bool! {
        get {
            return FBSDKAccessToken.currentAccessToken() != nil
        }
    }
    
    var userID : String! {
        get {
            return FBSDKAccessToken.currentAccessToken().userID
        }
    }
    
    var accessToken : String! {
        get {
            return FBSDKAccessToken.currentAccessToken().tokenString
        }
    }
    
    private lazy var sessionListeners : Array<AppSessionListener> = {
        return Array<AppSessionListener>()
    }()
    
    func logOut(err: NSError?) {
        sessionListeners.forEach { (listener: AppSessionListener) -> () in
            listener.userDidLogOut?(err)
        }
    }
    
    func logIn(err: NSError?) {
        sessionListeners.forEach { (listener: AppSessionListener) -> () in
            listener.userDidLogIn?(err)
        }
    }
    
    func addSessionListener(listener: AppSessionListener) {
        sessionListeners.append(listener)
    }
}
