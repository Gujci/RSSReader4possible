//
//  AppNavigationManager.swift
//  RSSReader
//
//  Created by Gujgiczer Máté on 22/12/15.
//  Copyright © 2015 Gujgiczer Máté. All rights reserved.
//

import UIKit

class AppNavigationManager: NSObject, UISplitViewControllerDelegate {
    
    static let sharedInstance = AppNavigationManager()
    
    private var mainWindow : UIWindow!
    private lazy var mainScreen: UISplitViewController! = {
        return UIStoryboard(name: "Main", bundle: nil).instantiateInitialViewController() as! UISplitViewController
    }()
    
    func setMainWindow(window: UIWindow?) {
        if let realWindow = window {
            mainWindow = realWindow
        }
        else {
            //TODO: - assert
        }
    }
    
    func startApplication() {
        mainScreen.delegate = self
        mainWindow.rootViewController = mainScreen
    }
    
    // MARK: - Split view
    func splitViewController(splitViewController: UISplitViewController, collapseSecondaryViewController secondaryViewController:UIViewController, ontoPrimaryViewController primaryViewController:UIViewController) -> Bool {
        
        return true
    }

}
