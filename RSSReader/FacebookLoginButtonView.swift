//
//  FacebookLoginButtonView.swift
//  RSSReader
//
//  Created by Gujgiczer Máté on 22/12/15.
//  Copyright © 2015 Gujgiczer Máté. All rights reserved.
//

import UIKit
import FBSDKLoginKit

class FacebookLoginButtonView: FBSDKLoginButton, FBSDKLoginButtonDelegate {
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.delegate = self
        self.readPermissions = [ "public_profile", "email", "user_friends" ]
    }
    
    //MARK: - Facebook Button delegate
    func loginButton(loginButton: FBSDKLoginButton!, didCompleteWithResult result: FBSDKLoginManagerLoginResult!, error: NSError!) {
        if result.isCancelled {
            AppDependencies.sharedInstance.appSessionHandler.logOut(error)
        }
        else {
            AppDependencies.sharedInstance.appSessionHandler.logIn(error)
        }
    }
    
    func loginButtonDidLogOut(loginButton: FBSDKLoginButton!) {
        AppDependencies.sharedInstance.appSessionHandler.logOut(nil)
    }
}
