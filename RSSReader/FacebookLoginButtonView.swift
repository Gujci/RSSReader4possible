//
//  FacebookLoginButtonView.swift
//  RSSReader
//
//  Created by Gujgiczer Máté on 22/12/15.
//  Copyright © 2015 Gujgiczer Máté. All rights reserved.
//

import UIKit
import FBSDKLoginKit

class FacebookLoginButtonView: FBSDKLoginButton {
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.delegate        = AppSessionHandler.sharedInstance
        self.readPermissions = [ "public_profile", "email", "user_friends" ]
    }
}
