//
//  FollowersViewCell.swift
//  Pickup Basketball App
//
//  Created by Ben Svoboda on 4/24/20.
//  Copyright © 2020 Hoop Break. All rights reserved.
//

import UIKit

class FollowersViewCell: UITableViewCell {

    @IBOutlet weak var namelabelfollowers: UILabel!
    @IBOutlet weak var usernamelabelfollowers: UILabel!
    @IBOutlet weak var pfpfollowers: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
