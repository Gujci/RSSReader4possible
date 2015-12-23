//
//  NewsFeedTableViewCell.swift
//  RSSReader
//
//  Created by Gujgiczer Máté on 22/12/15.
//  Copyright © 2015 Gujgiczer Máté. All rights reserved.
//

import UIKit

class NewsFeedTableViewCell: UITableViewCell {

    @IBOutlet weak var newTitle: UILabel!
    
    var titleData: String! {
        didSet {
            newTitle.text = titleData
        }
    }
}
