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

    @IBAction func Loginbuttonpressed(_ sender: Any) {
        print("button pressed")
        self.performSegue(withIdentifier: "Logintohomesegue", sender: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        print("Loaded sucessfully")
        UsernameTextField.delegate = self
        PasswordTextField.delegate = self

    }

    @IBAction func LoginTapped(_ sender: Any) {
        var user = UsernameTextField.text!
        var pass = PasswordTextField.text!
        print(user)
        print(pass)
    }
    
}
extension Loginviewcontroller : UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
