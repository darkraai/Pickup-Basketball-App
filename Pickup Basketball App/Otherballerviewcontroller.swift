//
//  OtherBaller.swift
//  Pickup Basketball App
//
//  Created by Ben Svoboda on 4/26/20.
//  Copyright © 2020 Hoop Break. All rights reserved.
//

import UIKit
import os.log


class Otherballerviewcontroller: UIViewController {
    
    var followusername:String?

    //irl it will fetch the appropriate one from the database using followusername which was passed here
    var surya = User(firstname: "Surya", lastname: "Mamidyala", username: "suryam", password: "jfowejeo", userweight: "157", hometown: "Reston", userheightinches: "10", userheightfeet: "5", position: "SF", profilepic: UIImage(named: "surya"))
    var ben = User(firstname: "Ben", lastname: "Svoboda", username: "bensvo", password: "fjjwoe", userweight: "215", hometown: "Huntington", userheightinches: "3", userheightfeet: "6", position: "PF", profilepic: UIImage(named: "ben"))
    var pranav = User(firstname: "Pranav", lastname: "Addepali", username: "pranavaddy", password: "SHAKTAAYYYY", userweight: "184", hometown: "Ashburn", userheightinches: "8", userheightfeet: "5", position: "C", profilepic: UIImage(named: "pranav"))
    
    var chosen1:User?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(followusername!)
        
        if(followusername == surya!.username){
            chosen1 = surya

        }
        
        if(followusername == ben!.username){
            chosen1 = ben

        }
        
        if(followusername == pranav!.username){
            chosen1 = pranav
        }
        
        //now chosen1 is the selected cell
        if(chosen1!.hometown == "N/A"){
            fatalError("You need to go through register")
        }
    }

    
}

