//
//  Registerviewcontroller.swift
//  Pickup Basketball App
//
//  Created by Ben Svoboda on 3/24/20.
//  Copyright © 2020 Hoop Break. All rights reserved.
//
import UIKit
import os.log
import FirebaseDatabase


class RegisterViewController: UIViewController,UITextFieldDelegate {

    
    
    //MARK: Properties
    
    var ref: DatabaseReference!
    
    @IBOutlet weak var userfirstname: UITextField!
    @IBOutlet weak var userlastname: UITextField!
    @IBOutlet weak var userusername: UITextField!
    @IBOutlet weak var userpassword: UITextField!
    @IBOutlet weak var registernext: UIBarButtonItem!
    



    
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference()
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
            let backItem = UIBarButtonItem()
            backItem.title = "Back"
            navigationItem.backBarButtonItem = backItem
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
        
        var check = true

        let userfirsttext = userfirstname.text ?? ""
        if userfirsttext.isEmpty{
            check = false
        }
        
        let userlasttext = userlastname.text ?? ""
        if userlasttext.isEmpty{
            check = false
        }
        
        let usernametext = userusername.text ?? ""
        if usernametext.isEmpty{
            check = false
        }
        
        let userpasswordtext = userpassword.text ?? ""
        if userpasswordtext.isEmpty{
            check = false
        }
        
        if (!usernametext.isEmpty){
            let charset = CharacterSet(charactersIn: ".#$[]")
            if usernametext.rangeOfCharacter(from: charset) != nil{
                check = false
                presentAlert()
            }
        }
        
        registernext.isEnabled = check
        

    }
    
    private func presentAlert(){
        let alertController = UIAlertController(title: "Enter another username", message: "The username you entered is already taken or contains one of the following characters '.#$[]'", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Try Again", style: .default, handler: nil)
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
    


}







