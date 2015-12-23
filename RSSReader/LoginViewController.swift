//
//  LoginViewController.swift
//  RSSReader
//
//  Created by Gujgiczer Máté on 23/12/15.
//  Copyright © 2015 Gujgiczer Máté. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController, AppSessionListener {

    override func viewDidLoad() {
        super.viewDidLoad()

        AppSessionHandler.sharedInstance.addSessionListener(self)
    }
    
    //MARK: - App Session listener
    func userDidLogIn(err: NSError?) {
        //TODO: -
    }
    
    func userDidLogOut(err: NSError?) {
        //TODO: -         
    }
}
