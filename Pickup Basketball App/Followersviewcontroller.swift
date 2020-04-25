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

    var nameData: [String] = ["Surya Mamidyala", "Benjamin Svoboda", "Pranav Addepalli"]
    var usernameData: [String] = ["@suryam", "@bensvo", "@pranavaddy"]
    var imageData: [UIImage] = [UIImage(named: "surya")!, UIImage(named: "ben")!, UIImage(named: "pranav")!]

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return nameData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellf = tableView.dequeueReusableCell(withIdentifier: "FollowersViewCell") as! FollowersViewCell
        cellf.namelabelfollowers.text = nameData[indexPath.row]
        cellf.usernamelabelfollowers.text = usernameData[indexPath.row]
        //cellf.pfpfollowers?.image = imageData[indexPath.row]
        return cellf
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(user24!.username)
        
    }
    

}
