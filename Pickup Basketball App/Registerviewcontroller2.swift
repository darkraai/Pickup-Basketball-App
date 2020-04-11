//
//  Registerviewcontroller2.swift
//  Pickup Basketball App
//
//  Created by Ben Svoboda on 4/6/20.


import UIKit
import os.log



class RegisterViewController2: UIViewController,UITextFieldDelegate, UIPickerViewDataSource, UIPickerViewDelegate {
    
    
    //MARK: Properties
    //@IBOutlet weak var userheightf: UITextField!
    @IBOutlet weak var userheighti: UITextField!
    @IBOutlet weak var userweight: UITextField!
    @IBOutlet weak var userage: UITextField!
    @IBOutlet weak var userhometown: UITextField!
    @IBOutlet weak var gamesplayed: UITextField!
    @IBOutlet weak var userposition: UITextField!
    @IBOutlet weak var registerdone: UIBarButtonItem!
    
    
    @IBOutlet weak var pickerviewheight: UIPickerView!
    
    let heightfeet = ["4","5","6","7"]

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return heightfeet[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        return heightfeet.count
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        var heightinfeet = heightfeet[row]
    }
    
        
        override func viewDidLoad() {
            super.viewDidLoad()
            // Do any additional setup after loading the view.
            //userheightf.delegate = self
            userheighti.delegate = self
            userweight.delegate = self
            userage.delegate = self
            userhometown.delegate = self
            gamesplayed.delegate = self
            userposition.delegate = self
            
            updateDoneButtonState2()

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
            updateDoneButtonState2()
            //navigationItem.title = textField.text
        }
        
        private func updateDoneButtonState2() {
            // Disable the login button if the text field is empty.

            //let userheightftext = userheightf.text ?? ""
            //registerdone.isEnabled = !userheightftext.isEmpty
            
            let userheightitext = userheighti.text ?? ""
            registerdone.isEnabled = !userheightitext.isEmpty
            
            let userweighttext = userweight.text ?? ""
            registerdone.isEnabled = !userweighttext.isEmpty
            
            let useragetext = userage.text ?? ""
            registerdone.isEnabled = !useragetext.isEmpty
            
            let userhometowntext = userhometown.text ?? ""
            registerdone.isEnabled = !userhometowntext.isEmpty
            
            let usergamesplayedtext = gamesplayed.text ?? ""
            registerdone.isEnabled = !usergamesplayedtext.isEmpty
            
            
            let usergamespositiontext = userposition.text ?? ""
            registerdone.isEnabled = !usergamespositiontext.isEmpty
        }
        
        
    }
