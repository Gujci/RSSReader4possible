//
//  DetailViewController.swift
//  RSSReader
//
//  Created by Gujgiczer Máté on 21/12/15.
//  Copyright © 2015 Gujgiczer Máté. All rights reserved.
//

import UIKit
import Social

class DetailViewController: UIViewController, RSSDataListener {

    private let dataProvider : RSSDataProvider = AppDependencies.sharedInstance.appRSSDataProvider
    
    @IBOutlet weak var contentWebView: UIWebView!
    var shareData: RSSData?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    //MARK: - RSSDataListener
    func rssDataSelectedAt(index: Int) {
        let url = NSURL(string: dataProvider.rssData[index].link)
        let request = NSURLRequest(URL: url!)
        contentWebView.loadRequest(request)
        
        shareData = dataProvider.rssData[index]
        navigationController?.title = dataProvider.rssData[index].title
    }
    
    //MARK: - Actions
    @IBAction func shareButtonPressed(sender: AnyObject) {
        if let data = shareData {
            let shareController = SLComposeViewController(forServiceType: SLServiceTypeFacebook)
            shareController.setInitialText(data.title)
            shareController.addURL(NSURL(string: (data.link)!))
            self.presentViewController(shareController, animated: true, completion: nil)
        }
    }
}

