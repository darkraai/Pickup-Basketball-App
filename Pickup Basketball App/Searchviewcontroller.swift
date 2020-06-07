//
//  Searchviewcontroller.swift
//  Pickup Basketball App
//
//  Created by Ben Svoboda on 4/18/20.
//  Copyright © 2020 Hoop Break. All rights reserved.
//


import UIKit
import os.log
import FirebaseDatabase
import FirebaseStorage

class Searchviewcontroller: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    //MARK: Properties
    
    var ref: DatabaseReference!
    
    var user24:User?
    
    var currentUsers = [User]()
    var tempUsernames = [String]()
    
    @IBOutlet weak var tableView: UITableView!
    
    var FullName:String?
    var FirstName:String?
    var LastName:String?
    var UserName: String?
    var ProfilePic:UIImage?
    var PFPLink:String?
    
    var searchController : UISearchController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ref = Database.database().reference()
        
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
     
    
    func filterCurrentDataSource (searchTerm: String) {
        if searchTerm.count > 0 {
            
            currentUsers.removeAll()
            self.tableView.reloadData()
            
            let searchValue = searchTerm.replacingOccurrences(of: " ", with: "").lowercased()
            let searchValue2 = searchTerm.lowercased()
            
            ref.child("Users").queryOrdered(byChild: "username").queryStarting(atValue: searchValue).queryEnding(atValue: searchValue + "\u{f8ff}").observeSingleEvent(of: .value) { (snapshot) in
                if let snapDict = snapshot.value as? [String:AnyObject]{
                    for each in snapDict{
                        self.UserName = each.value["username"] as? String
                        if (self.UserName != self.user24?.username){
                            self.FullName = each.value["fullname"] as? String
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
                            
                            self.tableView.reloadData()
                        }
                    }
                }
            }
            
            ref.child("Users").queryOrdered(byChild: "fullname").queryStarting(atValue: searchValue2).queryEnding(atValue: searchValue2 + "\u{f8ff}").observeSingleEvent(of: .value) { (snapshot) in
                if let snapDict = snapshot.value as? [String:AnyObject]{
                    
                    var tempUsers = [String]()
                    for user in self.currentUsers{
                        tempUsers.append(user.username)
                    }
                    for each in snapDict{
                        self.UserName = each.value["username"] as? String
                        if (self.UserName != self.user24?.username && !tempUsers.contains(self.UserName!)){
                            self.FullName = each.value["fullname"] as? String
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
                            
                            self.tableView.reloadData()
                        }
                    }
                }
            }
            
        }
    }
    
    func restoreCurrentDataSource() {
        currentUsers.removeAll()
        tableView.reloadData()
    }

    
}

extension Searchviewcontroller : UISearchResultsUpdating {

    func updateSearchResults(for searchController: UISearchController) {
    }
}

extension Searchviewcontroller : UISearchBarDelegate {

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchController.isEditing = false
        if let searchText = searchController.searchBar.text {
            filterCurrentDataSource(searchTerm: searchText)
        }
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
            restoreCurrentDataSource()
    }
}
