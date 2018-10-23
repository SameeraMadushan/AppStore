//
//  TableViewHelper.swift
//  appstore-search
//
//  Created by Nandika on 10/4/18.
//  Copyright © 2018 SLIIT. All rights reserved.
//

import Foundation
import UIKit

class TableViewHelper {
    
    class func EmptyMessage(_ message:String, view:UITableView) {
        let rect = CGRect(origin: CGPoint(x: 0,y :0), size: CGSize(width: view.bounds.size.width, height: view.bounds.size.height))
        let messageLabel = UILabel(frame: rect)
        messageLabel.text = message
        messageLabel.textColor = UIColor.gray
        messageLabel.numberOfLines = 0;
        messageLabel.textAlignment = .center;
        messageLabel.font = UIFont(name: "TrebuchetMS", size: 15)
        messageLabel.sizeToFit()
        
        view.backgroundView = messageLabel
        view.separatorStyle = .none
    }
}

