//
//  Registerviewcontroller.swift
//  Pickup Basketball App
//
//  Created by Ben Svoboda on 3/24/20.
//  Copyright © 2020 Hoop Break. All rights reserved.
//
//cleaned by bs

import UIKit
import os.log
import FirebaseDatabase
import FirebaseStorage

class RegisterViewController: UIViewController,UITextFieldDelegate {

    
    
    //MARK: Properties
    
    var ref: DatabaseReference!
    
    @IBOutlet weak var userfirstname: UITextField!
    @IBOutlet weak var userlastname: UITextField!
    @IBOutlet weak var userusername: UITextField!
    @IBOutlet weak var userpassword: UITextField!
    @IBOutlet weak var userreenterpassword: UITextField!
    @IBOutlet weak var registernext: UIBarButtonItem!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //creates database reference
        ref = Database.database().reference()

        //sets delegates
        userfirstname.delegate = self
        userlastname.delegate = self
        userusername.delegate = self
        userpassword.delegate = self
        userreenterpassword.delegate = self
        
        updateNextButtonState()

    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        //sends important user info to registerviewcontroller2
        let destinationViewController = segue.destination
        
        if let MainVC = destinationViewController as? RegisterViewController2{
            MainVC.fname = userfirstname.text
            MainVC.lname = userlastname.text
            MainVC.uname = userusername.text!.lowercased()
            MainVC.pword = userpassword.text
            let backItem = UIBarButtonItem()
            backItem.title = "Back"
            navigationItem.backBarButtonItem = backItem
        }
    }
    
    
    
    //MARK: UITextFieldDelegate
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
           // Hide the keyboard.
           textField.resignFirstResponder()
           return true
       }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        // Disable the Save button while editing.
        registernext.isEnabled = false
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        //when done editing, updates save button state
        updateNextButtonState()
    }
    
    

    //MARK: Private Methods

    private func updateNextButtonState() {
        // Disable the login button if the text field is empty.
        registernext.isEnabled = false

        
        var check = true
        var check2 = false

        //makes sure the user's first name is the right length
        let userfirsttext = userfirstname.text ?? ""
        if userfirsttext.isEmpty{
            check = false
            return
        } else if userfirsttext.count > 30{
            let alert = UIAlertController(title: "Error", message: "Your first name exceeded the limit of 30 characters. Please provide an abbreviated version.", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Retry", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            check = false
            return
        }
        
        //makes sure the user's last name is the right length
        let userlasttext = userlastname.text ?? ""
        if userlasttext.isEmpty{
            check = false
            return
        } else if userlasttext.count > 30{
            let alert = UIAlertController(title: "Error", message: "Your last name exceeded the limit of 30 characters. Please provide an abbreviated version.", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Retry", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            check = false
            return
        }
        
        //makes sure the user's username is the right length
        let usernametext = userusername.text ?? ""
        if usernametext.isEmpty{
            check = false
            return
        } else if usernametext.count > 30{
            let alert = UIAlertController(title: "Error", message: "Your username must be less than 30 characters in length.", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Retry", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            check = false
            return
        }
        
        //makes sure user password is correct length
        let userpasswordtext = userpassword.text ?? ""
        if userpasswordtext.isEmpty{
            check = false
            return
        } else if userpasswordtext.count > 30 || userpasswordtext.count < 8{
            let alert = UIAlertController(title: "Error", message: "Your password must be between 8 and 30 characters in length.", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Retry", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            check = false
            return
        }
        
        let userreentertext = userreenterpassword.text ?? ""
        if userreentertext.isEmpty{
            check = false
            return
        }
        
        //makes sure passwords math
        
        let userpasswordtext2 = userreenterpassword.text ?? ""
        
        if (!userpasswordtext.isEmpty && !userpasswordtext2.isEmpty){
            if(userreenterpassword.text! != userpassword.text){
                let alert = UIAlertController(title: "Error", message: "Your passwords must match", preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "Retry", style: UIAlertAction.Style.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                check = false
                return
            }
        }
        //makes sure username doesn't contain special characters
        if (!usernametext.isEmpty){
            let charset = CharacterSet(charactersIn: ".#$[]")
            if usernametext.rangeOfCharacter(from: charset) != nil{
                presentAlert()
                check = false
                return
            }
            
            //makes sure username isnt already taken
            ref.child("Users").queryOrdered(byChild: "username").queryEqual(toValue: usernametext).observeSingleEvent(of: .value) { (snapshot) in
                let snapDict = snapshot.value as? [String:AnyObject]
                if snapDict != nil{
                    check2 = false
                    self.presentAlert()
                } else {
                    check2 = true
                    self.registernext.isEnabled = check && check2

                }
                
            }
        }

    }
    
    //when function is called, an alert is presented
    private func presentAlert(){
        let alertController = UIAlertController(title: "Enter another username", message: "The username you entered is already taken or contains one of the following characters '.#$[]'", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Try Again", style: .default, handler: nil)
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
    


}







