//
//  Newcourtviewcontroller.swift
//  Pickup Basketball App
//
//  Created by Surya M on 4/6/20.
//  Copyright © 2020 Hoop Break. All rights reserved.
//
 
import UIKit
import MapKit
import FirebaseDatabase
import Firebase


class Newcourtviewcontroller: UIViewController, UITextFieldDelegate {
    
    //MARK: Properties
    @IBOutlet weak var parkNameTextField: UITextField!
    @IBOutlet weak var numCourtsTextField: UITextField!
    @IBOutlet weak var addressTextField: UITextField!
    @IBOutlet weak var indoorSwitch: UISwitch!
    @IBOutlet weak var membershipSwitch: UISwitch!
    @IBOutlet weak var startHoopingButton: UIButton!
    
    
    var ref:DatabaseReference!

    var coordinates:CLLocationCoordinate2D?
    var parkName = ""
    var numCourts = ""
    var address = ""
    var indoorSelected = false
    var membershipSelected = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference()
        parkNameTextField.delegate = self
        numCourtsTextField.delegate = self
        addressTextField.delegate = self
        indoorSwitch.isOn = false
        membershipSwitch.isOn = false
        updateDoneButtonState()
    }
    
    private func updateDoneButtonState(){
        startHoopingButton.isEnabled = false
        if (parkName != "" && numCourts != "" && CharacterSet(charactersIn: "1234567890").isSuperset(of: CharacterSet(charactersIn: numCourts))){
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
        
        self.ref.child("Parks").childByAutoId().setValue(["coordinateslat": coordinates!.latitude,"coordinateslong":coordinates!.longitude,"parkname":self.parkName,"numcourts":Int(self.numCourts)!, "Address":self.address, "indoor":self.indoorSelected, "membership":self.membershipSelected])
        
        parkNameTextField.text = ""
        numCourtsTextField.text = ""
        addressTextField.text = ""
        membershipSwitch.isOn = false
        indoorSwitch.isOn = false
    }
 
}
