//
//  MessageTableViewCell.swift
//  Mysterious
//
//  Created by Jason Wei on 7/9/19.
//  Copyright © 2019 Kaifan Wei. All rights reserved.
//

import UIKit

class MessageTableViewCell: UITableViewCell {

    
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var newLabel: UIImageView!
    
    var read = false
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        //newLabel.isHidden = read
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
