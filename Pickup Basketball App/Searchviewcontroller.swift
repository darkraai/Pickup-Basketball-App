//
//  Searchviewcontroller.swift
//  Pickup Basketball App
//
//  Created by Ben Svoboda on 4/18/20.
//  Copyright © 2020 Hoop Break. All rights reserved.
//


import UIKit
import os.log


class Searchviewcontroller: UIViewController, UISearchBarDelegate, UITableViewDelegate, UITableViewDataSource {
    
    var nameData: [String] = ["Surya Mamidyala", "Benjamin Svoboda", "Pranav Addepalli"]
    var usernameData: [String] = ["@suryam", "@bensvo", "@pranavaddy"]
    var imageData: [UIImage] = [UIImage(named: "surya")!, UIImage(named: "ben")!, UIImage(named: "pranav")!]
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return nameData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "searchTableViewCell") as! searchTableViewCell
        cell.nameLabel.text = nameData[indexPath.row]
        cell.usernameLabel.text = usernameData[indexPath.row]
        cell.imageView?.image = imageData[indexPath.row]
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
     
    
    //MARK: Properties
    var user24:User?

    
    override func viewDidLoad() {
        print(user24!.username)
        super.viewDidLoad()
        

    }

    
    @IBAction func searchButtonPressed(_ sender: Any) {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchBar.delegate = self
        present(searchController, animated:true, completion: nil)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {

    }
    

}
