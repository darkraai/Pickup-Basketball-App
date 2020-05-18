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
    
    var timeslot:String
    var gametype:String?
    var creator:String?
    var slotsfilled:Int
    var totalslots:Int
    var team1:[User]
    var team2:[User]
    var date: String?
    
    init?(timeslot: String, gametype: String, creator: String, slotsfilled: Int, team1: [User], team2: [User], date:String) {

        // Initialize stored properties.
        self.timeslot = timeslot
        self.gametype = gametype
        self.creator = creator
        self.slotsfilled = slotsfilled
        self.team1 = team1
        self.team2 = team2
        self.date = date
        if(gametype == "5 v 5"){
            self.totalslots = 10
        }
        else if(gametype == "4 v 4"){
            self.totalslots = 8
        }
        else if(gametype == "3 v 3"){
            self.totalslots = 6
        }
        if(gametype == "2 v 2"){
            self.totalslots = 4
        }
        else{
            self.totalslots = 2

        }

        

    }
    
    

    
}