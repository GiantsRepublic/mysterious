//
//  UtilityTableViewCell.swift
//  Mysterious
//
//  Created by Jason Wei on 7/9/19.
//  Copyright © 2019 Kaifan Wei. All rights reserved.
//

import UIKit

class UtilityTableViewCell: UITableViewCell {

    @IBOutlet var ticketNameLabel: UILabel!
    @IBOutlet var ticketLeftLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}