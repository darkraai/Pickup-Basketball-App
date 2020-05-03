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
    
    @IBOutlet weak var joinButton: UIButton!
    @IBOutlet weak var fullButton: UIButton!
    
    private func configureButtons(){
        joinButton.layer.cornerRadius = 5
        joinButton.setTitleColor(UIColor.white, for: .normal)
        joinButton.backgroundColor = UIColor.systemGreen
        fullButton.layer.cornerRadius = 5
        fullButton.setTitleColor(UIColor.white, for: .normal)
        fullButton.backgroundColor = UIColor.gray
    }
    
    
    
    var team1Data : [String] = ["@ayushluvshali", "@suryam", "@sirhalalyash"]
    var team2Data : [String] = ["@bensvo", "@lightskinb", "@xanmanshoota", "@treyvonsteals", "@awaldasnipa"]
    var team1Pics : [UIImage] = [UIImage(named: "ayush")!, UIImage(named: "surya")!, UIImage(named: "yashipoo")!]
    var team2Pics : [UIImage] = [UIImage(named: "ben")!, UIImage(named: "bik")!, UIImage(named: "xanman")!, UIImage(named: "trey")!,UIImage(named: "aryan")!]
    var team1first : [String] = ["Ayush", "Surya", "Yash"]
    var team1last : [String] = ["Hariharan", "Mamidyala", "Halal"]
    var team2first : [String] = ["Ben", "Bikram", "Xan", "Trey","Awal"]
    var team2last : [String] = ["Svoboda", "Kohli", "Manshoota", "Watts","Awal"]
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if team1Data.count > team2Data.count{
            return team1Data.count
        } else {
            return team2Data.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "JoinTableViewCell") as! JoinTableViewCell
        if team1Data.count > team2Data.count{
            cell.team1username.text = team1Data[indexPath.row]
            cell.team1fullname.text = team1first[indexPath.row] + " " + team1last[indexPath.row]
            cell.team1pfp.image = team1Pics[indexPath.row]
            if (indexPath.row < team2Data.count){
                cell.team2username.text = team2Data[indexPath.row]
                cell.team2fullname.text = team2first[indexPath.row] + " " + team2last[indexPath.row]
                cell.team2pfp.image = team2Pics[indexPath.row]

            }
        }
        if team2Data.count > team1Data.count{
            if (indexPath.row < team1Data.count){
                cell.team1username.text = team1Data[indexPath.row]
                cell.team1fullname.text = team1first[indexPath.row] + " " + team1last[indexPath.row]
                cell.team1pfp.image = team1Pics[indexPath.row]

            }
                cell.team2username.text = team2Data[indexPath.row]
                cell.team2fullname.text = team2first[indexPath.row] + " " + team2last[indexPath.row]
                cell.team2pfp.image = team2Pics[indexPath.row]

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
        configureButtons()

        
    }
    

 
}
