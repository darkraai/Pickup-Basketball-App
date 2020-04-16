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
    @IBOutlet weak var userusername: UITextField!
    @IBOutlet weak var userpassword: UITextField!
    @IBOutlet weak var registernext: UIBarButtonItem!
    



    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        userfirstname.delegate = self
        userlastname.delegate = self
        userusername.delegate = self
        userpassword.delegate = self
        
        updateNextButtonState()
    }
    

    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationViewController = segue.destination
        
        if let MainVC = destinationViewController as? RegisterViewController2{
            MainVC.fname = userfirstname.text
            MainVC.lname = userlastname.text
            MainVC.uname = userusername.text
            MainVC.pword = userpassword.text

        }
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
        registernext.isEnabled = false
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        //when done editing, updates save button state
        updateNextButtonState()
        //navigationItem.title = textField.text
    }
    
    

    //MARK: Private Methods

    private func updateNextButtonState() {
        // Disable the login button if the text field is empty.

        let userfirsttext = userfirstname.text ?? ""
        registernext.isEnabled = !userfirsttext.isEmpty
        
        let userlasttext = userlastname.text ?? ""
        registernext.isEnabled = !userlasttext.isEmpty
        
        let usernametext = userusername.text ?? ""
        registernext.isEnabled = !usernametext.isEmpty
        
        let userpasswordtext = userpassword.text ?? ""
        registernext.isEnabled = !userpasswordtext.isEmpty
    }
    


}







