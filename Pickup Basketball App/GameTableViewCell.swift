//
//  GameTableViewCell.swift
//  Pickup Basketball App
//
//  Created by Surya Mamidyala on 4/14/20.
//  Copyright © 2020 Hoop Break. All rights reserved.
//

import UIKit

class GameTableViewCell: UITableViewCell {
    
    //MARK: Properties
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var gameLabel: UILabel!
    @IBOutlet weak var ownerLabel: UILabel!
    @IBOutlet weak var slotsFilledLabel: UILabel!
    @IBOutlet weak var gameStatusButton: UIButton!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
