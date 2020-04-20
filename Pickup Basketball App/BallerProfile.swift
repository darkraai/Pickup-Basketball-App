//
//  BallerProfile.swift
//  Pickup Basketball App
//
//  Created by Ben Svoboda on 4/14/20.
//  Copyright © 2020 Hoop Break. All rights reserved.
//

import UIKit
import os.log


class BallerProfile: UIViewController {
    
    //MARK: Properties
    
    @IBOutlet weak var heightlabel: UILabel!
    @IBOutlet weak var weightlabel: UILabel!
    @IBOutlet weak var prefpositionlabel: UILabel!
    @IBOutlet weak var hometownlabel: UILabel!
    @IBOutlet weak var agelabel: UILabel!
    @IBOutlet weak var gamesplayedlabel: UILabel!
    @IBOutlet weak var fullnamelabel: UILabel!
    @IBOutlet weak var usernamelabel: UILabel!
    
    
    
    
    var user24:User?

    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(user24!.username)

        //configures height label
        if(user24!.userheightfeet != "N/A"){
        heightlabel.text = user24!.userheightfeet + " ' " + user24!.userheightinches + " \" "
        }
        
        //configures other labels based on class values
        weightlabel.text = user24!.userweight
        prefpositionlabel.text = user24!.position
        hometownlabel.text = user24!.hometown
        fullnamelabel.text = user24!.firstname + " " + user24!.lastname
        usernamelabel.text = "@" + user24!.username
        

    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationViewController = segue.destination
        
        if let MainVC94 = destinationViewController as? Editprofileviewcontroller{
            MainVC94.user24 = user24


        }
    }

}
