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
        joinButton.backgroundColor = UIColor.green
        fullButton.layer.cornerRadius = 5
        fullButton.setTitleColor(UIColor.white, for: .normal)
        fullButton.backgroundColor = UIColor.red
    }
    
    
    
    var team1Data : [String] = ["@ayushluvshali", "@suryam", "@sirhalalabdur"]
    var team2Data : [String] = ["@bensvo", "@lightskinb", "@xanmanshoota", "@treyvonsteals", "@awaldasnipa"]
    
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
            cell.team1Label.text = team1Data[indexPath.row]
            if (indexPath.row < team2Data.count){
                cell.team2Label.text = team2Data[indexPath.row]
            }
        }
        if team2Data.count > team1Data.count{
            if (indexPath.row < team1Data.count){
                cell.team1Label.text = team1Data[indexPath.row]
            }
                cell.team2Label.text = team2Data[indexPath.row]
        }
        
        return cell
    }
    
 
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureButtons()
    }
    

 
}
