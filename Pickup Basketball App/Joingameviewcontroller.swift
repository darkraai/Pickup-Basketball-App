//
//  Joingameviewcontroller.swift
//  Pickup Basketball App
//
//  Created by Ben Svoboda on 4/18/20.
//  Copyright © 2020 Hoop Break. All rights reserved.
//

import UIKit
import MapKit
 
 
class Joingameviewcontroller: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    
    @IBOutlet weak var teamstableview: UITableView!
    @IBOutlet weak var team1button: UIButton!
    @IBOutlet weak var team2button: UIButton!
    
    var user24:User?
    
    
    private func configureButtons(){
        
        if (totalslots!/2) > team1usersingame.count{
            team1button.layer.cornerRadius = 5
            team1button.setTitleColor(UIColor.white, for: .normal)
            team1button.backgroundColor = UIColor.systemGreen
            team1button.setTitle("Join", for: .normal)
        }
        else{
            team1button.layer.cornerRadius = 5
            team1button.setTitleColor(UIColor.white, for: .normal)
            team1button.backgroundColor = UIColor.gray
            team1button.setTitle("Full", for: .normal)

        }
        
        if (totalslots!/2) > team2usersingame.count{
            team2button.layer.cornerRadius = 5
            team2button.setTitleColor(UIColor.white, for: .normal)
            team2button.backgroundColor = UIColor.systemGreen
            team2button.setTitle("Join", for: .normal)

        }
        else{
            team2button.layer.cornerRadius = 5
            team2button.setTitleColor(UIColor.white, for: .normal)
            team2button.backgroundColor = UIColor.gray
            team2button.setTitle("Full", for: .normal)

        }
        
        
        

    }
    

    lazy var team1usersingame : [User] = []
    
    lazy var team2usersingame : [User] = []
    
    var totalslots : Int?
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if team1usersingame.count > team2usersingame.count{
            return team1usersingame.count
        } else {
            return team2usersingame.count
        }
    }
    
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
    
 
    
    override func viewDidLoad() {
        print("here too")
        super.viewDidLoad()
        

        configureButtons()

        
    }
    


    

 
}
