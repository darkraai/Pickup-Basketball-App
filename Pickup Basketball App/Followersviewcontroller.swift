//
//  Followersviewcontroller.swift
//  Pickup Basketball App
//
//  Created by Ben Svoboda on 4/24/20.
//  Copyright © 2020 Hoop Break. All rights reserved.
//

import UIKit
import os.log
import FirebaseDatabase
import FirebaseStorage


class Followersviewcontroller: UIViewController, UITableViewDelegate, UITableViewDataSource {

    
    var user24:User? //logged in user
    var userSelected:User? //other user selected
    
    var ref: DatabaseReference!
    
    var currentUsers = [User]() //currentUsers array with users to populate table
    
    var FullName:String?
    var FirstName:String?
    var LastName:String?
    var UserName: String?
    var ProfilePic:UIImage?
    var PFPLink:String?

    @IBOutlet weak var FollowersTableView: UITableView!
    
    override func viewWillAppear(_ animated: Bool) {
        filterCurrentDataSource() //every time viewcontroller appears, refresh screen
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ref = Database.database().reference()
        
        FollowersTableView.delegate = self
        FollowersTableView.dataSource = self
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currentUsers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //render the users that the user logged in follows in a table
        let cellf = tableView.dequeueReusableCell(withIdentifier: "FollowersViewCell", for: indexPath) as! FollowersViewCell
        let user = currentUsers[indexPath.row]
        cellf.namelabelfollowers.text = user.fullname
        cellf.usernamelabelfollowers.text = "@" + user.username
        cellf.pfpfollowers?.image = user.profilepic
        cellf.pfpfollowers.layer.cornerRadius = (cellf.pfpfollowers.frame.size.width)/2;
        cellf.pfpfollowers.clipsToBounds = true;
        return cellf
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //processes what happens when a follower is selected
        let usernameSelected = currentUsers[indexPath.row].username
        ref.child("Users").queryOrdered(byChild: "username").queryEqual(toValue: usernameSelected).observeSingleEvent(of: .value) { (snapshot) in
            if let snapDict = snapshot.value as? [String:AnyObject]{
                for each in snapDict{
                    self.currentUsers[indexPath.row].hometown = (each.value["hometown"] as? String)!
                    self.currentUsers[indexPath.row].position = (each.value["position"] as? String)!
                    self.currentUsers[indexPath.row].userweight = (each.value["weight"] as? String)!
                    self.currentUsers[indexPath.row].userheightfeet = (each.value["heightfeet"] as? String)!
                    self.currentUsers[indexPath.row].userheightinches = (each.value["heightinches"] as? String)!
                    self.userSelected = self.currentUsers[indexPath.row]
                    self.performSegue(withIdentifier: "followers_ballerinfo_segue", sender: self)
                }
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationViewController = segue.destination
        
        if let vc = destinationViewController as? Otherballerviewcontroller{
            //assign the chosen1 variable to the user selected on this screen and user24 variable to the user logged in
            vc.chosen1 = self.userSelected
            vc.user24 = user24
        }
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func filterCurrentDataSource(){
        currentUsers.removeAll()
        
        ref.child("Interactions").child(self.user24!.username).child("Followers").observeSingleEvent(of: .value) { (snapshot) in
            let value = snapshot.value as? [String:AnyObject]
            if value != nil{
                for username in value!.keys{
                    self.ref.child("Users").queryOrdered(byChild: "username").queryEqual(toValue: username).observeSingleEvent(of: .value) { (snapshot) in
                        if let snapDict = snapshot.value as? [String:AnyObject]{
                            for each in snapDict{
                                self.UserName = each.value["username"] as? String
                                self.FullName = (each.value["fullname"] as? String)!.components(separatedBy: " ")[0].capitalizingFirstLetter() + " " + (each.value["fullname"] as? String)!.components(separatedBy: " ")[1].capitalizingFirstLetter()
                                self.FirstName = self.FullName?.components(separatedBy: " ")[0]
                                self.LastName = self.FullName?.components(separatedBy: " ")[1]
                                self.PFPLink = each.value["pfp"] as? String
                                
                                let url = URL(string: self.PFPLink!)
                                do{
                                    let data = try Data(contentsOf: url!)
                                    self.ProfilePic = UIImage(data: data)
                                }catch _{
                                    self.ProfilePic = UIImage(named: "user")
                                    print("Error")
                                }
                                
                                let user = User(firstname: self.FirstName!, lastname: self.LastName!, username: self.UserName!, password: "", userweight: "", hometown: "", userheightinches: "", userheightfeet: "", position: "", profilepic: self.ProfilePic!, pfplink: self.PFPLink!)
                                
                                self.currentUsers.append(user!)
                                self.FollowersTableView.reloadData()
                            }
                        }
                    }
                }
            }
        }
    }
    

    

}
