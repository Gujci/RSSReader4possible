//
//  ProfileViewController.swift
//  RSSReader
//
//  Created by Gujgiczer Máté on 22/12/15.
//  Copyright © 2015 Gujgiczer Máté. All rights reserved.
//

import UIKit

protocol EmbededTableView {
   
    var contentHeight: CGFloat { get }
}

class ProfileViewController: UIViewController, UITextFieldDelegate, SubscriptionListener {

    let dataSource = AppDependencies.sharedInstance.appSubscriptionManager
    
    @IBOutlet weak var subscribedTableViewHeight: NSLayoutConstraint!
    var subscribedTableView : EmbededTableView!
    
    @IBOutlet weak var suggestionTableViewHeight: NSLayoutConstraint!
    var suggestedTableView : EmbededTableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        dataSource.addSubscriptionListener(self)
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        adjustHeight()
    }
    
    //MARK: - subscription listener
    func subscriptionDataDidChange() {
        adjustHeight()
    }
    
    private func adjustHeight() {
        subscribedTableViewHeight.constant = subscribedTableView.contentHeight + 2
        suggestionTableViewHeight.constant = suggestedTableView.contentHeight + 2
    }
    
    //MARK: - UITextField delegate
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        //TODO: - validate the url
        if let url = textField.text {
            dataSource.addNewFeed(withUrl: url)
        }
        
        textField.resignFirstResponder()
        textField.text = ""
        return true
    }

    //MARK: - Navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let id = segue.identifier {
            switch(id) {
            case "embed_subscribed_tableview":
                subscribedTableView = segue.destinationViewController as! EmbededTableView
                break
            case "embed_suggested_tableview":
                suggestedTableView = segue.destinationViewController as! EmbededTableView
                break
            default:
                break
            }
        }
    }
}
