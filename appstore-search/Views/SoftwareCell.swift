//
//  SoftwareCell.swift
//  appstore-search
//
//  Created by Nandika on 10/2/18.
//  Copyright © 2018 SLIIT. All rights reserved.
//

import UIKit

class SoftwareCell: UITableViewCell {

    @IBOutlet weak var appImageView: UIImageView!
    @IBOutlet weak var appName: UILabel!
    @IBOutlet weak var appCompanyName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
