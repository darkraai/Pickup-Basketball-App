//
//  FirstViewController.swift
//  Pickup Basketball App
//
//  Created by Surya M on 3/22/20.
//  Copyright © 2020 Hoop Break. All rights reserved.
//

import os.log
import UIKit
import FirebaseDatabase
import FirebaseStorage

class Loginviewcontroller: UIViewController, UITextFieldDelegate {

    //MARK: Properties
   
    var ref: DatabaseReference!
    
    var FirstName:String?
    var LastName:String?
    var Password:String?
    var UserWeight:String?
    var Hometown:String?
    var UserHeightInches:String?
    var UserHeightFeet:String?
    var Position:String?
    var ProfilePic:UIImage?
    var PFPLink:String?
    
    @IBOutlet weak var UsernameTextField: UITextField!
    @IBOutlet weak var PasswordTextField: UITextField!
    @IBOutlet weak var LoginButton: UIButton!
    @IBOutlet weak var donthaveaccount: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ref = Database.database().reference()
        
        UsernameTextField.delegate = self
        PasswordTextField.delegate = self
        
        updateLoginButtonState()
    }


    @IBAction func LoginTapped(_ sender: Any) {
        let user = UsernameTextField.text!.lowercased()
        let pass = PasswordTextField.text!
        
        ref.child("Users").queryOrdered(byChild: "username").queryStarting(atValue: user).queryEnding(atValue: user + "\u{f8ff}").observeSingleEvent(of: .value, with: { (snapshot) in
            if let snapDict = snapshot.value as? [String:AnyObject]{
                for each in snapDict{
                    self.Password = each.value["password"] as? String
                    if (pass == self.Password){
                        self.FirstName = each.value["firstname"] as? String
                        self.LastName = each.value["lastname"] as? String
                        self.Hometown = each.value["hometown"] as? String
                        self.Position = each.value["position"] as? String
                        self.PFPLink = each.value["pfp"] as? String
                        self.UserWeight = each.value["weight"] as? String
                        self.UserHeightFeet = each.value["heightfeet"] as? String
                        self.UserHeightInches = each.value["heightinches"] as? String
                        self.performSegue(withIdentifier: "Logintohomesegue", sender: self)
                    }else{
                        self.presentAlert1()
                    }
                }
            }else{
                self.presentAlert2()
            }
        })
    }
    
    private func presentAlert1(){
        let alertController = UIAlertController(title: "Incorrect password for \(UsernameTextField.text!)", message: "The password you entered is incorrect. Please try again.", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Try Again", style: .default, handler: nil)
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
    
    private func presentAlert2(){
        let alertController = UIAlertController(title: "Enter another username", message: "The username entered does not exist.", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Try Again", style: .default, handler: nil)
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "Logintohomesegue" else {return}

        let url = URL(string: self.PFPLink!)
        do{
            let data = try Data(contentsOf: url!)
            self.ProfilePic = UIImage(data: data)
        }catch _{
            print("Error")
        }
        
        let barViewControllers = segue.destination as! UITabBarController
        //confirmed sets firstdc to nav controller before  baller profile
        let navvcbp = barViewControllers.viewControllers![3] as! navballerprofile
        
        let finalvcbp = navvcbp.topViewController as! BallerProfile
 
        finalvcbp.user24 = User(firstname: self.FirstName!, lastname: self.LastName!, username: UsernameTextField.text!, password: self.Password!, userweight: self.UserWeight!, hometown: self.Hometown!, userheightinches: self.UserHeightInches!, userheightfeet: self.UserHeightFeet!, position: self.Position!, profilepic: self.ProfilePic!, pfplink: self.PFPLink!)
        
        let navh = barViewControllers.viewControllers![0] as! navhome
        
        let finalvch = navh.topViewController as! Homeviewcontroller
        
        finalvch.user24 = User(firstname: self.FirstName!, lastname: self.LastName!, username: UsernameTextField.text!, password: self.Password!, userweight: self.UserWeight!, hometown: self.Hometown!, userheightinches: self.UserHeightInches!, userheightfeet: self.UserHeightFeet!, position: self.Position!, profilepic: self.ProfilePic!, pfplink: self.PFPLink!)
        
        let navs = barViewControllers.viewControllers![1] as! navsearch
        
        let finalvcs = navs.topViewController as! Searchviewcontroller
        
        finalvcs.user24 = User(firstname: self.FirstName!, lastname: self.LastName!, username: UsernameTextField.text!, password: self.Password!, userweight: self.UserWeight!, hometown: self.Hometown!, userheightinches: self.UserHeightInches!, userheightfeet: self.UserHeightFeet!, position: self.Position!, profilepic: self.ProfilePic!, pfplink: self.PFPLink!)
        
        
        let navac = barViewControllers.viewControllers![2] as! navaddcourt
        
        let finalvcac = navac.topViewController as! Tabnewcourtviewcontroller
        
        finalvcac.user24 = User(firstname: self.FirstName!, lastname: self.LastName!, username: UsernameTextField.text!, password: self.Password!, userweight: self.UserWeight!, hometown: self.Hometown!, userheightinches: self.UserHeightInches!, userheightfeet: self.UserHeightFeet!, position: self.Position!, profilepic: self.ProfilePic!, pfplink: self.PFPLink!)
        
    }
    
    
    
    
    //MARK: UITextFieldDelegate
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
           // Hide the keyboard.
           textField.resignFirstResponder()
           return  true
       }
    
    //Disables the login button while the user is editing the text field
    func textFieldDidBeginEditing(_ textField: UITextField) {
        // Disable the Save button while editing.
        LoginButton.isEnabled = false
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        //when done editing, updates save button state
        updateLoginButtonState()
    }
    
    

    //MARK: Private Methods

    private func updateLoginButtonState() {
        // Disable the login button if the text field is empty.
        var check = true
        
        let usertext = UsernameTextField.text ?? ""
        if usertext.isEmpty{
            check = false
        }
        
        let passtext = PasswordTextField.text ?? ""
        if passtext.isEmpty{
            check = false
        }
        
        LoginButton.isEnabled = check

    }
    
}






