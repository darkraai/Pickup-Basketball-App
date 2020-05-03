//
//  game.swift
//  Pickup Basketball App
//
//  Created by Ben Svoboda on 5/1/20.
//  Copyright © 2020 Hoop Break. All rights reserved.
//

import UIKit
import os.log

class Game {
    
    var start:Date
    var end:Date
    var gametype:String
    var creator:String
    var slotsfilled:String
    var team1:[User]
    var team2:[User]
    
    init?(start: Date, end: Date, gametype: String, creator: String, slotsfilled: String, team1: [User], team2: [User]) {

        // Initialize stored properties.

        self.start = start
        self.end = end
        self.gametype = gametype
        self.creator = creator
        self.slotsfilled = slotsfilled
        self.team1 = team1
        self.team2 = team2


        
    }
    
    

    
}
