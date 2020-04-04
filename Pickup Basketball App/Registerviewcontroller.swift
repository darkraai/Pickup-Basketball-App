//
//  Registerviewcontroller.swift
//  Pickup Basketball App
//
//  Created by Ben Svoboda on 3/24/20.
//  Copyright © 2020 Hoop Break. All rights reserved.
//
import UIKit
import os.log



class RegisterViewController: UIViewController,UITextFieldDelegate {

    
    
    //MARK: Properties
    @IBOutlet weak var userfirstname: UITextField!
    @IBOutlet weak var userlastname: UITextField!
    @IBOutlet weak var useremail: UITextField!
    @IBOutlet weak var userusername: UITextField!
    @IBOutlet weak var userpassword: UITextField!
    @IBOutlet weak var registerdone: UIBarButtonItem!
    
    
    /* @IBAction func DoneTapped(_ sender: UIBarButtonItem) {
    }
    
    */
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        userfirstname.delegate = self
        userlastname.delegate = self
        useremail.delegate = self
        userusername.delegate = self
        userpassword.delegate = self
        
        updateDoneButtonState()
    }
    
    //MARK: UITextFieldDelegate
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
           // Hide the keyboard.
           textField.resignFirstResponder()
           return  true
       }
    
    //Disables the done button while the user is editing the text field
    func textFieldDidBeginEditing(_ textField: UITextField) {
        // Disable the Save button while editing.
        registerdone.isEnabled = false
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        //when done editing, updates save button state
        updateDoneButtonState()
        //navigationItem.title = textField.text
    }
    
    

    

    private func updateDoneButtonState() {
        // Disable the login button if the text field is empty.

        let userfirsttext = userfirstname.text ?? ""
        registerdone.isEnabled = !userfirsttext.isEmpty
        
        let userlasttext = userlastname.text ?? ""
        registerdone.isEnabled = !userlasttext.isEmpty

        let useremailtext = useremail.text ?? ""
        registerdone.isEnabled = !useremailtext.isEmpty
        
        let usernametext = userusername.text ?? ""
        registerdone.isEnabled = !usernametext.isEmpty
        
        let userpasswordtext = userpassword.text ?? ""
        registerdone.isEnabled = !userpasswordtext.isEmpty
    }
    


}
