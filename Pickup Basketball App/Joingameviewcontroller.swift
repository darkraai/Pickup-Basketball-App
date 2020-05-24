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
    @IBOutlet weak var joinButton: UIButton!
    @IBOutlet weak var fullButton: UIButton!
    
    var user24:User?
    
    
    private func configureButtons(){
        joinButton.layer.cornerRadius = 5
        joinButton.setTitleColor(UIColor.white, for: .normal)
        joinButton.backgroundColor = UIColor.systemGreen
        fullButton.layer.cornerRadius = 5
        fullButton.setTitleColor(UIColor.white, for: .normal)
        fullButton.backgroundColor = UIColor.gray
    }
    

    lazy var team1usersingame : [User] = []
    
    lazy var team2usersingame : [User] = []
    

    
    
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
        super.viewDidLoad()
        print("team1")
        for x in team1usersingame{
            print(x.fullname)
        }
        print("team2")
        for y in team2usersingame{
            print(y.fullname)
        }
        print(team1usersingame.count)
        print(team2usersingame.count)
        
        configureButtons()

        
    }
    


    

 
}
