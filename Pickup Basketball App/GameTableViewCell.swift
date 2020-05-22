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
    
    var gameitem: Game!
    var gameid: String?
    var delegate: delegate?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func setGame(game: Game){
        gameitem = game
        timeLabel.text! = game.timeslot
        gameLabel.text! = game.gametype!
        ownerLabel.text! = game.creator!
        
    }
    
    @IBAction func Joinbutton(_ sender: Any) {
        delegate?.didtapbutton(timeslot: gameitem.timeslot)
    }
    

}

protocol delegate {
    func didtapbutton(timeslot: String)
}
