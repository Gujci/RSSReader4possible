//
//  AppNavigationManager.swift
//  RSSReader
//
//  Created by Gujgiczer Máté on 22/12/15.
//  Copyright © 2015 Gujgiczer Máté. All rights reserved.
//

import UIKit

class AppNavigationManager: NSObject, UISplitViewControllerDelegate, AppSessionListener {
    
    static let sharedInstance = AppNavigationManager()
    
    private var mainWindow : UIWindow!
    private var mainScreen: UIViewController! {
        get {
            let screen = UIStoryboard(name: "Main", bundle: nil).instantiateInitialViewController() as! UISplitViewController
            screen.delegate = self
            return screen
        }
    }
    private var loginScreen: UIViewController! {
        get {
            return UIStoryboard(name: "Login", bundle: nil).instantiateInitialViewController()
        }
    }
    
    override init() {
        super.init()
        AppSessionHandler.sharedInstance.addSessionListener(self)
    }
    
    func setMainWindow(window: UIWindow?) {
        if let realWindow = window {
            mainWindow = realWindow
        }
    }
    
    func startApplication(animated: Bool = false) {
        let newRoot = !AppSessionHandler.sharedInstance.isUserLoggedIn ? loginScreen : mainScreen
        if animated {
            UIView.transitionWithView(mainWindow, duration: 0.3, options: .TransitionCrossDissolve, animations: { () -> Void in
                self.mainWindow.rootViewController = newRoot
                },
                completion: nil)
        }
        else {
            self.mainWindow.rootViewController = newRoot
        }
    }
    
    // MARK: - Session listener 
    func userDidLogIn(err: NSError?) {
        if let _ = err {
            return
        }
        startApplication(true)
    }
    
    func userDidLogOut(err: NSError?) {
        if let _ = err {
            return
        }
        startApplication(true)
    }
    
    // MARK: - Split view
    func splitViewController(splitViewController: UISplitViewController, collapseSecondaryViewController secondaryViewController:UIViewController, ontoPrimaryViewController primaryViewController:UIViewController) -> Bool {
        return true
    }
}
