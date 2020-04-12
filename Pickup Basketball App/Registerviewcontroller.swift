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
    @IBOutlet weak var registernext: UIBarButtonItem!
    
    var firstname: String = ""
    var lastname: String = ""
    var username: String = ""
    var password: String = ""


    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        userfirstname.delegate = self
        userlastname.delegate = self
        userusername.delegate = self
        userpassword.delegate = self
        
        updateNextButtonState()
    }
    
    
    
    @IBAction func nextButton(_ sender: Any) {
        self.firstname = userfirstname.text!
        self.lastname = userlastname.text!
        self.username = userusername.text!
        self.password = userpassword.text!
        performSegue(withIdentifier: "reg1toreg2", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as! RegisterViewController2
        vc.username = self.firstname
        vc.password = self.password
        vc.firstname = self.firstname
        vc.lastname = self.lastname
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
