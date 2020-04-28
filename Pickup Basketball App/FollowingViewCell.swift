//
//  FollowingViewCell.swift
//  Pickup Basketball App
//
//  Created by Ben Svoboda on 4/25/20.
//  Copyright © 2020 Hoop Break. All rights reserved.
//

import UIKit

class FollowingViewCell: UITableViewCell {

    @IBOutlet weak var nameLabelFollowing: UILabel!
    @IBOutlet weak var usernameLabelFollowing: UILabel!
    @IBOutlet weak var pfpFollowing: UIImageView!
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
