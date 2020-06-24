//
//  BallerProfile.swift
//  Pickup Basketball App
//
//  Created by Ben Svoboda on 4/14/20.
//  Copyright © 2020 Hoop Break. All rights reserved.
//
//cleaned by bs


import UIKit
import os.log
import FirebaseDatabase
import FirebaseStorage


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
    @IBOutlet weak var followersBtn: UIButton!
    @IBOutlet weak var followingBtn: UIButton!
    
    
    @IBOutlet weak var navtitle: UINavigationItem!
    
    var user24:User?
    
    var ref: DatabaseReference!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ref = Database.database().reference()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //pulls the counts for followers and following from the database and updates them in the baller profile accordingly
        
        //configures height label
        if(user24!.userheightfeet != "N/A"){
        heightlabel.text = user24!.userheightfeet + " ' " + user24!.userheightinches + " \" "
        }
        else{
            editprofbutton.isEnabled = false
        }
        //configures other labels based on passed values
        weightlabel.text = user24!.userweight
        prefpositionlabel.text = user24!.position
        hometownlabel.text = user24!.hometown
        fullnamelabel.text = user24!.firstname + " " + user24!.lastname
        bpprofilepic.image = user24?.profilepic
        
        //updates the following count on the baller profile
        ref.child("Interactions").child(self.user24!.username).child("Following").observeSingleEvent(of: .value) { (snapshot) in
            if let snapshots = snapshot.children.allObjects as? [DataSnapshot] {
                self.followingBtn.setTitle("\(snapshots.count) Following", for: .normal)
            } else {
                self.followingBtn.setTitle("0 Following", for: .normal)
            }
        }
        
        //updates the followers count on the baller profile
        ref.child("Interactions").child(self.user24!.username).child("Followers").observeSingleEvent(of: .value) { (snapshot) in
            if let snapshots = snapshot.children.allObjects as? [DataSnapshot] {
                self.followersBtn.setTitle("\(snapshots.count) Followers", for: .normal)
            }else {
                self.followersBtn.setTitle("0 Followers", for: .normal)
            }
        }
        
        self.bpprofilepic.layer.cornerRadius = self.bpprofilepic.frame.size.width / 2;
        self.bpprofilepic.clipsToBounds = true;
        
        //sets title to username
        navtitle.title = user24?.username

        
    }
    
    

    @IBAction func unwindtobp(_ sender: UIStoryboardSegue) {
    }
    
    //if followers is pressed, goes to vc that shows followers
    @IBAction func followersBtnPressed(_ sender: Any) {
        self.performSegue(withIdentifier: "bptofollowers", sender: self)
    }
    
    //if following is pressed, goes to vc that shows following
    @IBAction func followingBtnPressed(_ sender: Any) {
        self.performSegue(withIdentifier: "bptofollowing", sender: self)
    }

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "bptoeditbp"){
            let destinationViewController = segue.destination
            if let MainVC94 = destinationViewController as? Editprofileviewcontroller{
                //sends info to edit
                    MainVC94.user24 = user24
                    let backItem = UIBarButtonItem()
                    backItem.title = "Back"
                    navigationItem.backBarButtonItem = backItem

            }
        }
        //sends user to follower screen
        if(segue.identifier == "bptofollowers"){
            let destinationViewController = segue.destination
            if let MainVC97 = destinationViewController as? Followersviewcontroller{
                    MainVC97.user24 = user24

            }

        }
        
        //sends user to following screen
        if(segue.identifier == "bptofollowing"){
            let destinationViewController = segue.destination
            if let MainVC99 = destinationViewController as? Followingviewcontroller{
                    MainVC99.user24 = user24
                    
            }
        }
            

        
    }
}
