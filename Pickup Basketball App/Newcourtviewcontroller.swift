//
//  Newcourtviewcontroller.swift
//  Pickup Basketball App
//
//  Created by Surya M on 4/6/20.
//  Copyright © 2020 Hoop Break. All rights reserved.
//
 
import UIKit
import MapKit
 
 
class Newcourtviewcontroller: UIViewController, UITextFieldDelegate {
    
    //MARK: Properties
    @IBOutlet weak var parkNameTextField: UITextField!
    @IBOutlet weak var numCourtsTextField: UITextField!
    @IBOutlet weak var addressTextField: UITextField!
    @IBOutlet weak var indoorSwitch: UISwitch!
    @IBOutlet weak var membershipSwitch: UISwitch!
    @IBOutlet weak var startHoopingButton: UIButton!
    
    
    var parkName = ""
    var numCourts = ""
    var address = ""
    var indoorSelected = false
    var membershipSelected = false
    
 
    var annotation: MKPointAnnotation!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        parkNameTextField.delegate = self
        numCourtsTextField.delegate = self
        addressTextField.delegate = self
        indoorSwitch.isOn = false
        membershipSwitch.isOn = false
        updateDoneButtonState()
    }
    
    private func updateDoneButtonState(){
        startHoopingButton.isEnabled = false
        if (parkName != "" && numCourts != ""){
            startHoopingButton.isEnabled = true
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == parkNameTextField{
            parkName = parkNameTextField.text!
        } else if textField == numCourtsTextField{
            numCourts = numCourtsTextField.text!
        } else {
            address = addressTextField.text!
        }
        updateDoneButtonState()
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
           // Hide the keyboard.
           textField.resignFirstResponder()
           return true
       }
    
    @IBAction func indoorSwitchToggled(_ sender: UISwitch) {
        if (sender.isOn){
            indoorSelected = true
        } else {
            indoorSelected = false
        }
    }
    
    @IBAction func membershipSwitchToggled(_ sender: UISwitch) {
        if (sender.isOn){
            membershipSelected = true
        } else {
            membershipSelected = false
        }
    }
    

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

    }
 
}

