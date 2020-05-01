//
//  JoinTableViewCell.swift
//  Pickup Basketball App
//
//  Created by Surya Mamidyala on 4/19/20.
//  Copyright © 2020 Hoop Break. All rights reserved.
//

import UIKit

class JoinTableViewCell: UITableViewCell {
    
    //MARK: Properties
    @IBOutlet weak var team1username: UILabel!
    @IBOutlet weak var team2username: UILabel!
    @IBOutlet weak var team1fullname: UILabel!
    @IBOutlet weak var team2fullname: UILabel!
    @IBOutlet weak var team1pfp: UIImageView!
    @IBOutlet weak var team2pfp: UIImageView!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
