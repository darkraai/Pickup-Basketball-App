//
//  OtherBaller.swift
//  Pickup Basketball App
//
//  Created by Ben Svoboda on 4/26/20.
//  Copyright © 2020 Hoop Break. All rights reserved.
//

import UIKit
import os.log
import FirebaseDatabase
import FirebaseStorage

class Otherballerviewcontroller: UIViewController {
    
    
    //MARK: Properties
    
    var ref: DatabaseReference!
    
    var followusername:String?
    
    var chosen1:User?
    
    var user24:User?
    
    //labels
    @IBOutlet weak var fullnamelabel2: UILabel!
    @IBOutlet weak var heightlabel2: UILabel!
    @IBOutlet weak var weightlabel2: UILabel!
    @IBOutlet weak var prefpositionlabel2: UILabel!
    @IBOutlet weak var hometownlabel2: UILabel!
    
    
    @IBOutlet weak var followersNumberBtn: UIButton!
    @IBOutlet weak var followingNumberBtn: UIButton!
    
    //image view
    @IBOutlet weak var obprofilepic: UIImageView!
    
    //nav item
    @IBOutlet weak var navtitle: UINavigationItem!
    
    //button
    @IBOutlet weak var followbutton: UIButton!
    
    //in this function, we will need to connect to database to get the interaction that hold followers and following
    @IBAction func followpressed(_ sender: Any) {
        
        if(followbutton.titleLabel!.text! == "Following"){
            self.ref.child("Interactions").child(self.user24!.username).child("Following").child("\(chosen1!.username)").setValue(nil)
            self.ref.child("Interactions").child(self.chosen1!.username).child("Followers").child("\(user24!.username)").setValue(nil)
            followbutton.setTitle("Follow", for: .normal)
        }
        else if(followbutton.titleLabel!.text! == "Follow"){
            self.ref.child("Interactions").child(self.user24!.username).child("Following").child("\(chosen1!.username)").setValue(true)
            self.ref.child("Interactions").child(self.chosen1!.username).child("Followers").child("\(user24!.username)").setValue(true)
            followbutton.setTitle("Following", for: .normal)

        }
        else{
            fatalError("L in da chat")
        }
        
    }
    
    //gets followers via database and displays it in followersviewcontroller
    @IBAction func followerBtnPressed(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(identifier: "Followersviewcontroller") as Followersviewcontroller
        vc.user24 = self.chosen1
        navigationController?.pushViewController(vc, animated: true)
    }
    
    //gets following via database and displays it in followingsviewcontroller
    @IBAction func followingBtnPressed(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(identifier: "Followingviewcontroller") as Followingviewcontroller
        vc.user24 = self.chosen1
        navigationController?.pushViewController(vc, animated: true)
    }
    
    

    
    override func viewWillAppear(_ animated: Bool) {
        
        ref = Database.database().reference()
        
        //now chosen1 is the selected cell
        if(chosen1!.hometown == "N/A"){
            fatalError("users in followers/following aren't properly configured")
        }
        
        //sets labels that show the characteristics of other baller
        fullnamelabel2.text = chosen1!.firstname.capitalizingFirstLetter() + " " + chosen1!.lastname.capitalizingFirstLetter()
        obprofilepic.image = chosen1?.profilepic
        heightlabel2.text = chosen1!.userheightfeet + " ' " + chosen1!.userheightinches + " \" "
        weightlabel2.text = chosen1!.userweight
        prefpositionlabel2.text = chosen1!.position
        hometownlabel2.text = chosen1!.hometown
        
        //gets number of following and changes button title accordingly
        ref.child("Interactions").child(self.chosen1!.username).child("Following").observeSingleEvent(of: .value) { (snapshot) in
            if let snapshots = snapshot.children.allObjects as? [DataSnapshot] {
                self.followingNumberBtn.setTitle("\(snapshots.count) Following", for: .normal)
            } else {
                self.followingNumberBtn.setTitle("0 Following", for: .normal)
            }
        }
        
        //gets number of followers and changes button title accordingly
        ref.child("Interactions").child(self.chosen1!.username).child("Followers").observeSingleEvent(of: .value) { (snapshot) in
            if let snapshots = snapshot.children.allObjects as? [DataSnapshot] {
                self.followersNumberBtn.setTitle("\(snapshots.count) Followers", for: .normal)
                
                let value = snapshot.value as? [String:AnyObject]
                let followers = value?.keys
                
                if ((followers?.contains(self.user24!.username)) == true){
                    self.followbutton.setTitle("Following", for: .normal)
                } else {
                    self.followbutton.setTitle("Follow", for: .normal)
                }
                
            }else {
                self.followersNumberBtn.setTitle("0 Followers", for: .normal)
            }
        }
        
        self.obprofilepic.layer.cornerRadius = self.obprofilepic.frame.size.width / 2;
        self.obprofilepic.clipsToBounds = true;
        
        navtitle.title = chosen1?.username
                
    }
    
    
    

    
}

extension String {
    func capitalizingFirstLetter() -> String {
        return prefix(1).capitalized + dropFirst()
    }

    mutating func capitalizeFirstLetter() {
        self = self.capitalizingFirstLetter()
    }
}

