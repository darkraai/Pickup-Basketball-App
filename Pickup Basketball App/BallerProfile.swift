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
    @IBOutlet weak var fullnamelabel: UILabel!
    //edit button
    @IBOutlet weak var editprofbutton: UIButton!
    @IBOutlet weak var bpprofilepic: UIImageView!
    
    
    @IBOutlet weak var navtitle: UINavigationItem!
    
    var user24:User?

    
    override func viewDidLoad() {
        super.viewDidLoad()

        

        

    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        //configures height label
        if(user24!.userheightfeet != "N/A"){
        heightlabel.text = user24!.userheightfeet + " ' " + user24!.userheightinches + " \" "
        }
        else{
            editprofbutton.isEnabled = false

        }
        //configures other labels based on class values
        weightlabel.text = user24!.userweight
        prefpositionlabel.text = user24!.position
        hometownlabel.text = user24!.hometown
        fullnamelabel.text = user24!.firstname + " " + user24!.lastname
        bpprofilepic.image = user24?.profilepic
        
        
        self.bpprofilepic.layer.cornerRadius = self.bpprofilepic.frame.size.width / 2;
        self.bpprofilepic.clipsToBounds = true;
        
        navtitle.title = user24?.username

        
    }
    
    

    @IBAction func unwindtobp(_ sender: UIStoryboardSegue) {
    }
    

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "bptoeditbp"){
            let destinationViewController = segue.destination
            if let MainVC94 = destinationViewController as? Editprofileviewcontroller{
                    MainVC94.user24 = user24
                    let backItem = UIBarButtonItem()
                    backItem.title = "Back"
                    navigationItem.backBarButtonItem = backItem

            }
        }
        if(segue.identifier == "bptofollowers"){
            let destinationViewController = segue.destination
            if let MainVC97 = destinationViewController as? Followersviewcontroller{
                    MainVC97.user24 = user24

            }

        }
        
        if(segue.identifier == "bptofollowing"){
            let destinationViewController = segue.destination
            if let MainVC99 = destinationViewController as? Followingviewcontroller{
                    MainVC99.user24 = user24
                    
            }
        }
        

        
    }
}
