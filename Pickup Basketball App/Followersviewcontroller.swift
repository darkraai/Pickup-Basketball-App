//
//  Followersviewcontroller.swift
//  Pickup Basketball App
//
//  Created by Ben Svoboda on 4/24/20.
//  Copyright © 2020 Hoop Break. All rights reserved.
//

import UIKit
import os.log



class Followersviewcontroller: UIViewController, UITableViewDelegate, UITableViewDataSource {

    
    var user24:User?

    @IBOutlet weak var FollowersTableView: UITableView!
    
    var nameData: [String] = ["Surya Mamidyala", "Benjamin Svoboda", "Pranav Addepalli"]
    var usernameData: [String] = ["suryam", "bensvo", "pranavaddy"]
    var imageData: [UIImage] = [UIImage(named: "surya")!, UIImage(named: "ben")!, UIImage(named: "pranav")!]

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return nameData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellf = tableView.dequeueReusableCell(withIdentifier: "FollowersViewCell") as! FollowersViewCell
        cellf.namelabelfollowers.text = nameData[indexPath.row]
        cellf.usernamelabelfollowers.text = "@" + usernameData[indexPath.row]
        cellf.pfpfollowers?.image = imageData[indexPath.row]
        cellf.pfpfollowers.layer.cornerRadius = 45;
        cellf.pfpfollowers.clipsToBounds = true;
        return cellf
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedusername = usernameData[indexPath.row]
        if let viewController = storyboard?.instantiateViewController(identifier: "Otherballerviewcontroller") as? Otherballerviewcontroller {
            //username passed to next VC
            viewController.followusername = selectedusername
            navigationController?.pushViewController(viewController, animated: true)
        }
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        FollowersTableView.delegate = self
        FollowersTableView.dataSource = self

    }
    

    

}
