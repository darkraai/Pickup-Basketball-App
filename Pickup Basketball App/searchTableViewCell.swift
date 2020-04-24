//
//  searchTableViewCell.swift
//  Pickup Basketball App
//
//  Created by Surya Mamidyala on 4/22/20.
//  Copyright © 2020 Hoop Break. All rights reserved.
//

import UIKit

class searchTableViewCell: UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var userImage: UIImageView!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }

}
