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
    
    
    //MARK: Properties
    var followusername:String?
    
    //labels
    @IBOutlet weak var fullnamelabel2: UILabel!
    @IBOutlet weak var heightlabel2: UILabel!
    @IBOutlet weak var weightlabel2: UILabel!
    @IBOutlet weak var prefpositionlabel2: UILabel!
    @IBOutlet weak var hometownlabel2: UILabel!
    
    //image view
    @IBOutlet weak var obprofilepic: UIImageView!
    
    //nav item
    @IBOutlet weak var navtitle: UINavigationItem!
    
    //button
    @IBOutlet weak var followbutton: UIButton!
    
    //in this function, we will need to connect to database
    @IBAction func followpressed(_ sender: Any) {
        
        if(followbutton.titleLabel!.text! == "Following"){
            followbutton.setTitle("Follow", for: .normal)
        }
        else if(followbutton.titleLabel!.text! == "Follow"){
            followbutton.setTitle("Following", for: .normal)

        }
        else{
            fatalError("L in da chat")
        }
        
    }
    
    
    //irl it will fetch the appropriate one from the database using followusername which was passed here
    var surya = User(firstname: "Surya", lastname: "Mamidyala", username: "suryam", password: "jfowejeo", userweight: "157", hometown: "Reston", userheightinches: "10", userheightfeet: "5", position: "SF", profilepic: UIImage(named: "surya"), pfplink: "N/A")
    var ben = User(firstname: "Ben", lastname: "Svoboda", username: "bensvo", password: "fjjwoe", userweight: "215", hometown: "Huntington", userheightinches: "3", userheightfeet: "6", position: "PF", profilepic: UIImage(named: "ben"), pfplink: "N/A")
    var pranav = User(firstname: "Pranav", lastname: "Addepali", username: "pranavaddy", password: "SHAKTAAYYYY", userweight: "184", hometown: "Ashburn", userheightinches: "8", userheightfeet: "5", position: "C", profilepic: UIImage(named: "pranav"), pfplink: "N/A")
    
    var chosen1:User?
    
    override func viewWillAppear(_ animated: Bool) {
        
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
            fatalError("users in followers/following aren't properly configured")
        }
        
        fullnamelabel2.text = chosen1!.firstname + " " + chosen1!.lastname
        obprofilepic.image = chosen1?.profilepic
        heightlabel2.text = chosen1!.userheightfeet + " ' " + chosen1!.userheightinches + " \" "
        weightlabel2.text = chosen1!.userweight
        prefpositionlabel2.text = chosen1!.position
        hometownlabel2.text = chosen1!.hometown
        
        
        
        self.obprofilepic.layer.cornerRadius = self.obprofilepic.frame.size.width / 2;
        self.obprofilepic.clipsToBounds = true;
        
        navtitle.title = chosen1?.username
                
    }
    
    

    
}

