//
//  FirstViewController.swift
//  Pickup Basketball App
//
//  Created by Surya M on 3/22/20.
//  Copyright © 2020 Hoop Break. All rights reserved.
//

import UIKit

class Loginviewcontroller: UIViewController {

    @IBOutlet weak var UsernameTextField: UITextField!
    @IBOutlet weak var PasswordTextField: UITextField!

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

    }

    //When login is tapped,  it saves the username and password
    @IBAction func LoginTapped(_ sender: Any) {
        var user = UsernameTextField.text!
        var pass = PasswordTextField.text!
        print(user)
        print(pass)
    }
    
}
extension Loginviewcontroller : UITextFieldDelegate{
    //when return is clicked, the keyboard dissapears by resigning first responder
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
