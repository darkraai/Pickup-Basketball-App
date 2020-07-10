//
//  Joingameviewcontroller.swift
//  Pickup Basketball App
//
//  Created by Ben Svoboda on 4/18/20.
//  Copyright © 2020 Hoop Break. All rights reserved.
//
//cleaned by bs


import UIKit
import MapKit
import FirebaseDatabase
import GoogleMobileAds
 
 
class Joingameviewcontroller: UIViewController, UITableViewDelegate, UITableViewDataSource, GADInterstitialDelegate {
    
    
    
    @IBOutlet weak var teamstableview: UITableView!
    @IBOutlet weak var team1button: UIButton!
    @IBOutlet weak var team2button: UIButton!
    
    
    
    var user24:User?
    
    var chosengamestatus: String?
    
    var timeslotforalert: String?
    
    var courtnameforalert: String?
    
    var alltimeslotsids:[String] = []
    
    var chosengameid: String?
    
    var user24team: String?
    
    var key1: String?
    
    var key2: String?
    
    var unislotsfilled: Int?
    
    var ref:DatabaseReference?
        
    var team1users:[String] = []
    
    var team2users:[String] = []
    
    var interstitial: GADInterstitial!
    
    lazy var team1usersingame : [User] = []
    
    lazy var team2usersingame : [User] = []
    
    var totalslots : Int?
    
    var appflow : Int?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        interstitial = createAndLoadInterstitial()
        
        
    }
    
    //sets the characteristics of each of the two buttons
    private func configureButtons(){
        
        if ((chosengamestatus == "Joined") && (user24team == "team 1"))
        {
            team1button.layer.cornerRadius = 5
            team1button.setTitleColor(UIColor.white, for: .normal)
            team1button.backgroundColor = UIColor.orange
            team1button.setTitle("Joined", for: .normal)
            team1button.isEnabled = false
            
            
            team2button.layer.cornerRadius = 5
            team2button.setTitleColor(UIColor.white, for: .normal)
            team2button.backgroundColor = UIColor.gray
            team2button.setTitle("Opponent", for: .normal)
            team2button.isEnabled = false
            
            return

        }
        else if (totalslots!/2) > team1usersingame.count{
            team1button.layer.cornerRadius = 5
            team1button.setTitleColor(UIColor.white, for: .normal)
            team1button.backgroundColor = UIColor.systemGreen
            team1button.setTitle("Join", for: .normal)
            team1button.isEnabled = true

        }
        else{
            team1button.layer.cornerRadius = 5
            team1button.setTitleColor(UIColor.white, for: .normal)
            team1button.backgroundColor = UIColor.gray
            team1button.setTitle("Full", for: .normal)
            team1button.isEnabled = false


        }
        
        if ((chosengamestatus == "Joined") && (user24team == "team 2"))
        {
            team2button.layer.cornerRadius = 5
            team2button.setTitleColor(UIColor.white, for: .normal)
            team2button.backgroundColor = UIColor.orange
            team2button.setTitle("Joined", for: .normal)
            team2button.isEnabled = false
            
            
            team1button.layer.cornerRadius = 5
            team1button.setTitleColor(UIColor.white, for: .normal)
            team1button.backgroundColor = UIColor.gray
            team1button.setTitle("Opponent", for: .normal)
            team1button.isEnabled = false
            
            return

        }
        else if (totalslots!/2) > team2usersingame.count{
            team2button.layer.cornerRadius = 5
            team2button.setTitleColor(UIColor.white, for: .normal)
            team2button.backgroundColor = UIColor.systemGreen
            team2button.setTitle("Join", for: .normal)
            team2button.isEnabled = true


        }
        else{
            team2button.layer.cornerRadius = 5
            team2button.setTitleColor(UIColor.white, for: .normal)
            team2button.backgroundColor = UIColor.gray
            team2button.setTitle("Full", for: .normal)
            team2button.isEnabled = false

        }
        
        
    }
    


    
    //determines the number of rows in the tableview
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if team1usersingame.count > team2usersingame.count{
            return team1usersingame.count
        } else {
            return team2usersingame.count
        }
    }
    
    //adds users into the tableview
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "JoinTableViewCell") as! JoinTableViewCell
        if team1usersingame.count > team2usersingame.count{
            cell.team1username.text = team1usersingame[indexPath.row].username
            cell.team1fullname.text = team1usersingame[indexPath.row].firstname + " " + team1usersingame[indexPath.row].lastname
            cell.team1pfp.image = team1usersingame[indexPath.row].profilepic!
            if (indexPath.row < team2usersingame.count){
                cell.team2username.text = team2usersingame[indexPath.row].username
                cell.team2fullname.text = team2usersingame[indexPath.row].firstname + " " + team2usersingame[indexPath.row].lastname
                cell.team2pfp.image = team2usersingame[indexPath.row].profilepic!
            }
        }
        if team2usersingame.count > team1usersingame.count{
            if (indexPath.row < team1usersingame.count){
                cell.team1username.text = team1usersingame[indexPath.row].username
                cell.team1fullname.text = team1usersingame[indexPath.row].firstname + " " + team1usersingame[indexPath.row].lastname
                cell.team1pfp.image = team1usersingame[indexPath.row].profilepic

            }
            cell.team2username.text = team2usersingame[indexPath.row].username
            cell.team2fullname.text = team2usersingame[indexPath.row].firstname + " " + team2usersingame[indexPath.row].lastname
            cell.team2pfp.image = team2usersingame[indexPath.row].profilepic!

        }
        
        if team1usersingame.count == team2usersingame.count{
            cell.team1username.text = team1usersingame[indexPath.row].username
            cell.team1fullname.text = team1usersingame[indexPath.row].firstname + " " + team1usersingame[indexPath.row].lastname
            cell.team1pfp.image = team1usersingame[indexPath.row].profilepic
            cell.team2username.text = team2usersingame[indexPath.row].username
            cell.team2fullname.text = team2usersingame[indexPath.row].firstname + " " + team2usersingame[indexPath.row].lastname
            cell.team2pfp.image = team2usersingame[indexPath.row].profilepic!
            
        }
        
        //configures image view for team 1
        cell.team1pfp.layer.cornerRadius = (cell.team1pfp.frame.size.width)/2;
        cell.team1pfp.clipsToBounds = true;
        //configures image view for team 2
        cell.team2pfp.layer.cornerRadius = (cell.team2pfp.frame.size.width)/2;
        cell.team2pfp.clipsToBounds = true;

        return cell
    }
    
 
    
    //activates google ads
    func createAndLoadInterstitial() -> GADInterstitial {
        //let interstitial = GADInterstitial(adUnitID: "ca-app-pub-3940256099942544/4411468910")
        let interstitial = GADInterstitial(adUnitID: "ca-app-pub-3329292800278297/8727794495")
        interstitial.delegate = self
        interstitial.load(GADRequest())
        return interstitial
    }
    
    func interstitialDidDismissScreen(_ ad: GADInterstitial) {
        interstitial = createAndLoadInterstitial()
        if self.appflow == 1{
                   ref = Database.database().reference().child("Games")
                   ref?.observeSingleEvent(of: DataEventType.value, with: {(snapshot) in
                       if snapshot.childrenCount > 0{
                           for game3 in snapshot.children.allObjects as![DataSnapshot]{
                               
                               var counter = 0
                               let gam3 = game3.value as? [String:AnyObject]
                               let timeslot = gam3?["timeslot"] as! String
                               let gamemode = gam3?["gametype"] as! String
                               let creator = gam3?["creator"] as! String
                               let team1 = gam3?["team 1"] as! [String]
                               let team2 = gam3?["team 2"] as! [String]
                               
                               //calculates the number of slots filled
                               for _ in team1{
                                   counter+=1
                               }
                               
                               for b in team2{
                                   if(b != "placeholder"){
                                       counter+=1
                                   }
                               }
                               counter+=1
                               
                               self.unislotsfilled = counter
                           
                               //makes sure the user is being added to the right game and adds the user to that game
                               for x in self.alltimeslotsids{
                                   if((x == game3.key) && (self.chosengameid == (timeslot + gamemode + creator))){
                                       for b in team1{
                                           self.team1users.append(b)
                                           self.key1 = game3.key
                                       }
                                       
                                   }
                               }
                               
                               
                               
                           }
                           
                           //edits slotsfilled and team1 in the database
                           self.ref?.child(self.key1!).child("slotsfilled").setValue(self.unislotsfilled!)

                           self.team1users.append(self.user24!.username)

                           
                           self.ref?.child(self.key1!).child("team 1").setValue(self.team1users)

                           
                           self.presentAlert()

                       }
                       //unwinds to home
                       self.performSegue(withIdentifier: "unwindtohome", sender: UIStoryboardSegue.self)
            
                   })
        }
        
        if self.appflow == 2{
            team2users.removeAll()
            
            ref = Database.database().reference().child("Games")
            ref?.observeSingleEvent(of: DataEventType.value, with: {(snapshot) in
                if snapshot.childrenCount > 0{
                    for game3 in snapshot.children.allObjects as![DataSnapshot]{
                        
                        var counter = 0
                        let gg = game3.value as? [String:AnyObject]
                        let timeslot = gg?["timeslot"] as! String
                        let gamemode = gg?["gametype"] as! String
                        let creator = gg?["creator"] as! String
                        let team1 = gg?["team 1"] as! [String]
                        let team2 = gg?["team 2"] as! [String]
                        _ = gg?["slotsfilled"] as! Int
                        
                        
                        
                        
                        self.key2 = game3.key
                        
                        
                        
                        if ((team2.contains("placeholder")) && (self.chosengameid == (timeslot + gamemode + creator))){
                            //counts number of slots
                            for _ in team1{
                                counter+=1
                            }
                            
                            for b in team2{
                                if(b != "placeholder"){
                                    counter+=1
                                }
                            }
                            counter+=1
                            
                            self.unislotsfilled = counter
                            
                            self.ref?.child(self.key2!).child("slotsfilled").setValue(self.unislotsfilled!)
                            self.unislotsfilled = counter
                            self.team2users.append(self.user24!.username)
                            self.ref?.child(self.key2!).child("team 2").setValue(self.team2users)
                            
                            self.presentAlert()
                            
                            self.performSegue(withIdentifier: "unwindtohome", sender: UIStoryboardSegue.self)
                        }
                        else if (((team2.contains("placeholder")) == false) && (self.chosengameid == (timeslot + gamemode + creator))){
                            //counts number of slots
                            for _ in team1{
                                counter+=1
                            }
                            
                            for b in team2{
                                if(b != "placeholder"){
                                    counter+=1
                                }
                            }
                            counter+=1
                            
                            self.unislotsfilled = counter
                            
                            //sets number of slots in database
                            self.ref?.child(self.key2!).child("slotsfilled").setValue(self.unislotsfilled!)
                            
                            //makes sure the user is being added to the right game and time is being
                            for x in self.alltimeslotsids{
                                if((x == game3.key) && (self.chosengameid == (timeslot + gamemode + creator))){
                                    for b in team2{
                                        self.team2users.append(b)
                                        self.key2 = game3.key
                                    }
                                }
                            }
                            
                            self.team2users.append(self.user24!.username)
                            
                            //adds the user via database
                            self.ref?.child(self.key2!).child("team 2").setValue(self.team2users)
                            self.presentAlert()
                            
                            //unwinds to home
                            self.performSegue(withIdentifier: "unwindtohome", sender: UIStoryboardSegue.self)
                        }
                        
                        
                    }
                    
                    
                    
                }
                
                
            })
        }
    }
    
    func interstitial(_ ad: GADInterstitial, didFailToReceiveAdWithError error: GADRequestError) {
        print(error)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        teamstableview.reloadData()
        configureButtons()

    }
    
    
    
    @IBAction func button1pressed(_ sender: UIButton) {
        
        self.appflow = 1
        
        if interstitial.isReady{
            interstitial.present(fromRootViewController: self)
        } else {
            print("Ad wasn't ready.")
        }
        
        team1button.isEnabled = false
    
    }
    
    //tells the user that they've sucessfully joined a game
    private func presentAlert(){
        let alertController = UIAlertController(title: "Sucess", message: "You have joined a " + timeslotforalert! + " game at " + courtnameforalert!, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default, handler: {_ in CATransaction.setCompletionBlock({
            
            self.performSegue(withIdentifier: "unwindtohome", sender: UIStoryboardSegue.self)
            
        })
            
            
        })
             
            
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
    
    @IBAction func button2pressed(_ sender: Any) {
        
        self.appflow = 2
        
        if interstitial.isReady{
            interstitial.present(fromRootViewController: self)
        } else {
            print("Ad wasn't ready.")
        }
        
        team2button.isEnabled = false
        
    }
    
    
}
