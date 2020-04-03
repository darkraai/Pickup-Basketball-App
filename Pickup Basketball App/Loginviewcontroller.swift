//
//  FirstViewController.swift
//  Pickup Basketball App
//
//  Created by Surya M on 3/22/20.
//  Copyright © 2020 Hoop Break. All rights reserved.
//

import os.log
import UIKit


class Loginviewcontroller: UIViewController, UITextFieldDelegate {

    //MARK: Properties
    
    @IBOutlet weak var UsernameTextField: UITextField!
    @IBOutlet weak var PasswordTextField: UITextField!
    @IBOutlet weak var LoginButton: UIButton!
    @IBOutlet weak var donthaveaccount: UIButton!
    
    /*@IBAction func donthaveaccountpressed(_ sender: Any) {
            self.performSegue(withIdentifier: "logtoreg", sender: self)
        }
    */
    
    //When login is tapped,  it goes to home page
    @IBAction func Loginbuttonpressed(_ sender: Any) {
        self.performSegue(withIdentifier: "Logintohomesegue", sender: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        //sets text field delegates to themselves
        UsernameTextField.delegate = self
        PasswordTextField.delegate = self
        
        updateLoginButtonState()
    }

    //When login is tapped,  it saves the username and password
    @IBAction func LoginTapped(_ sender: Any) {
        var user = UsernameTextField.text!
        var pass = PasswordTextField.text!
        print("Username:" + user)
        print("Password:" + pass)

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
/*extension Loginviewcontroller : UITextFieldDelegate{
    //when return is clicked, the keyboard dissapears by resigning first responder
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
*/

