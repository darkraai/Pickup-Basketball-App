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


class Loginviewcontroller: UIViewController, UITextFieldDelegate {

    //MARK: Properties
    
    var ref: DatabaseReference!
    
    @IBOutlet weak var UsernameTextField: UITextField!
    @IBOutlet weak var PasswordTextField: UITextField!
    @IBOutlet weak var LoginButton: UIButton!
    @IBOutlet weak var donthaveaccount: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        //sets text field delegates to themselves
        ref = Database.database().reference()
        UsernameTextField.delegate = self
        PasswordTextField.delegate = self
        
        updateLoginButtonState()
    }

    //When login is tapped,  it saves the username and password
    @IBAction func LoginTapped(_ sender: Any) {
        var user = UsernameTextField.text!
        var pass = PasswordTextField.text!
        ref.child("Users").queryOrdered(byChild:  "username").queryStarting(atValue: user).queryEnding(atValue: user + "\u{f8ff}").observeSingleEvent(of: .value, with: { (snapshot) in
            print(snapshot)
            if let snapDict = snapshot.value as? [String:AnyObject]{
                print(snapDict)
                for each in snapDict{
                    let key = each.key as! String
                    let password = each.value["password"] as! String
                    print(key)
                    print(password)
                    if (pass == password){
                        self.performSegue(withIdentifier: "Logintohomesegue", sender: self)
                    }else{
                        self.presentAlert()
                    }
                }
            }
        })
    }
    
    private func presentAlert(){
        let alertController = UIAlertController(title: "Incorrect password for \(UsernameTextField.text!)", message: "The password you entered is incorrect. Please try again.", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Try Again", style: .default, handler: nil)
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "Logintohomesegue" else {return}
        let barViewControllers = segue.destination as! UITabBarController
        //confirmed sets firstdc to nav controller before  baller profile
        let navvcbp = barViewControllers.viewControllers![3] as! navballerprofile
        
        let finalvcbp = navvcbp.topViewController as! BallerProfile
        
        finalvcbp.user24 = User(firstname: "N/A", lastname: "N/A", username: UsernameTextField.text!, password: PasswordTextField.text!, userweight: "N/A", hometown: "N/A", userheightinches: "N/A", userheightfeet: "N/A", position: "N/A", profilepic: UIImage(named: "user"))
        
        let navh = barViewControllers.viewControllers![0] as! navhome
        
        let finalvch = navh.topViewController as! Homeviewcontroller
        
        finalvch.user24 = User(firstname: "N/A", lastname: "N/A", username: UsernameTextField.text!, password: PasswordTextField.text!, userweight: "N/A", hometown: "N/A", userheightinches: "N/A", userheightfeet: "N/A", position: "N/A", profilepic: UIImage(named: "user"))
        
        let navs = barViewControllers.viewControllers![1] as! navsearch
        
        let finalvcs = navs.topViewController as! Searchviewcontroller
        
        finalvcs.user24 = User(firstname: "N/A", lastname: "N/A", username: UsernameTextField.text!, password: PasswordTextField.text!, userweight: "N/A", hometown: "N/A", userheightinches: "N/A", userheightfeet: "N/A", position: "N/A", profilepic: UIImage(named: "user"))
        
        
        let navac = barViewControllers.viewControllers![2] as! navaddcourt
        
        let finalvcac = navac.topViewController as! Tabnewcourtviewcontroller
        
        finalvcac.user24 = User(firstname: "N/A", lastname: "N/A", username: UsernameTextField.text!, password: PasswordTextField.text!, userweight: "N/A", hometown: "N/A", userheightinches: "N/A", userheightfeet: "N/A", position: "N/A", profilepic: UIImage(named: "user"))
        
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
        //navigationItem.title = textField.text
    }
    
    

    //MARK: Private Methods

    private func updateLoginButtonState() {
        // Disable the login button if the text field is empty.

        let usertext = UsernameTextField.text ?? ""
        LoginButton.isEnabled = !usertext.isEmpty
        
        let passtext = PasswordTextField.text ?? ""
        LoginButton.isEnabled = !passtext.isEmpty

    }
    
}


