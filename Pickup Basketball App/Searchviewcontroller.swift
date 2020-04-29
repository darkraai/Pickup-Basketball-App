//
//  Searchviewcontroller.swift
//  Pickup Basketball App
//
//  Created by Ben Svoboda on 4/18/20.
//  Copyright © 2020 Hoop Break. All rights reserved.
//


import UIKit
import os.log


class Searchviewcontroller: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    var users = [User]()
    var currentUsers = [User]()
    
    var firstNameData: [String] = ["Surya", "Benjamin", "Pranav", "Aryan"]
    var lastNameData: [String] = ["Mamidyala", "Svoboda", "Addepalli", "Awal"]
    var usernameData: [String] = ["suryam", "bensvo", "pranavaddy", "awaldasnipa"]
    var imageData: [UIImage] = [UIImage(named: "surya")!, UIImage(named: "ben")!, UIImage(named: "pranav")!, UIImage(named: "aryan")!]
    var nameData: [String] = []
    var currentNameData : [String] = []
    var currentUsernameData : [String] = []
    var searchController : UISearchController!
    var boolFilter : [Bool] = []
    var counter = 0
    
    override func viewDidLoad() {
//        print(user24!.username)
        super.viewDidLoad()
        loadSampleUsers()
        currentUsers = users
        tableView.delegate = self
        tableView.dataSource = self
        searchController = UISearchController(searchResultsController: nil)
        
        searchController.searchResultsUpdater = self
        
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.obscuresBackgroundDuringPresentation = false
        
        navigationItem.titleView = searchController.searchBar
        searchController.searchBar.delegate = self
        
        self.definesPresentationContext = true
    }
    
    func loadSampleUsers(){
        for index in 0..<firstNameData.count {
            guard let user = User(firstname: firstNameData[index], lastname: lastNameData[index], username: usernameData[index], password: "password", userweight: "100", hometown: "Ashburn", userheightinches: "0", userheightfeet: "6", position: "PG", profilepic: imageData[index]) else{
                fatalError("Unable to instantiate user")
            }
            nameData.append(user.fullname)
            users.append(user)
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currentUsers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "searchTableViewCell", for: indexPath) as! searchTableViewCell
        let user = currentUsers[indexPath.row]
        cell.nameLabel.text = user.fullname
        cell.usernameLabel.text = user.username
        cell.userImage.image = user.profilepic
        cell.userImage.layer.cornerRadius = (cell.userImage.frame.size.width)/2;
        cell.userImage.clipsToBounds = true;
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let alertController = UIAlertController(title: "Selection", message: "Selected: \(currentUsers[indexPath.row].fullname)", preferredStyle: .alert)
        searchController.isActive = false
        let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
     
    
    //MARK: Properties
    var user24:User?


    
    func filterCurrentDataSource (searchTerm: String) {
        if searchTerm.count > 0 {
            currentUsers = users

            let filteredResults = nameData.filter { $0.replacingOccurrences(of: " ", with: "").lowercased().contains(searchTerm.replacingOccurrences(of: " ", with: "").lowercased())}
            boolFilter.removeAll()
            for name in nameData{
                if filteredResults.contains(name){
                    boolFilter.append(true)
                    print("Filtered Results contains: \(name)")
                } else{
                    boolFilter.append(false)
                    print("Filtered Results doesn't contain: \(name)")
                }
            }
            counter = 0
            for (index,bool) in boolFilter.enumerated(){
                if bool == true{
                    continue
                } else{
                    currentUsers.remove(at: index + counter)
                    counter -= 1
                }
            }
            tableView.reloadData()
        }
    }
    
    func restoreCurrentDataSource() {
        currentUsers = users
        tableView.reloadData()
    }

    
}

extension Searchviewcontroller : UISearchResultsUpdating {

    func updateSearchResults(for searchController: UISearchController) {
        if let searchText = searchController.searchBar.text{
            filterCurrentDataSource(searchTerm: searchText)
        }
    }
}

extension Searchviewcontroller : UISearchBarDelegate {

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchController.isActive = false
        if let searchText = searchBar.text {
            filterCurrentDataSource(searchTerm: searchText)
        }
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
            restoreCurrentDataSource()
        
    }
}
