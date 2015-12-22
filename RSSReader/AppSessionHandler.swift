//
//  AppSessionHandler.swift
//  RSSReader
//
//  Created by Gujgiczer Máté on 22/12/15.
//  Copyright © 2015 Gujgiczer Máté. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import FBSDKLoginKit

@objc protocol AppSessionListener {

    optional func userDidLogIn(err: NSError?);
    optional func userDidLogOut(err: NSError?);

}

class AppSessionHandler: NSObject, FBSDKLoginButtonDelegate {

    static let sharedInstance = AppSessionHandler()
    
    var isUserLoggedIn : Bool! {
        get {
            return FBSDKAccessToken.currentAccessToken() != nil
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
    
    //MARK: - Facebook
    func inintFacebookSDK(withApplication application: UIApplication, launchOptions: [NSObject: AnyObject]?) -> Bool {
        return FBSDKApplicationDelegate.sharedInstance().application(
            application,
            didFinishLaunchingWithOptions: launchOptions
        )
    }
    
    //MARK: - Facebook Button delegate
    func loginButton(loginButton: FBSDKLoginButton!, didCompleteWithResult result: FBSDKLoginManagerLoginResult!, error: NSError!) {
        if result.isCancelled {
            logOut(error)
        }
        else {
            logIn(error)
        }
    }
    
    func loginButtonDidLogOut(loginButton: FBSDKLoginButton!) {
        logOut(nil)
    }
}
