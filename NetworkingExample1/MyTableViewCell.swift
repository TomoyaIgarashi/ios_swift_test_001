//
//  MyTableViewCell.swift
//  NetworkingExample1
//
//  Created by TomoyaIgarashi on 8/17/15.
//  Copyright (c) 2015 Couger Inc. All rights reserved.
//

import UIKit

class MyTableViewCell: UITableViewCell {

    @IBOutlet weak var imageView1: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
