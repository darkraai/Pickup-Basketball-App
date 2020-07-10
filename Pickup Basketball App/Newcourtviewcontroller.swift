//
//  Newcourtviewcontroller.swift
//  Pickup Basketball App
//
//  Created by Surya M on 4/6/20.
//  Copyright © 2020 Hoop Break. All rights reserved.
//
//cleaned by bs

 
import UIKit
import MapKit
import FirebaseDatabase
import Firebase


class Newcourtviewcontroller: UIViewController, UITextFieldDelegate, GADInterstitialDelegate {
    
    //MARK: Properties
    @IBOutlet weak var parkNameTextField: UITextField!
    @IBOutlet weak var numCourtsTextField: UITextField!
    @IBOutlet weak var addressTextField: UITextField!
    @IBOutlet weak var indoorSwitch: UISwitch!
    @IBOutlet weak var membershipSwitch: UISwitch!
    @IBOutlet weak var startHoopingButton: UIButton!
    
    
    var ref:DatabaseReference!
    
    var interstitial: GADInterstitial!

    var coordinates:CLLocationCoordinate2D?
    var parkName = ""
    var numCourts = ""
    var address = ""
    var indoorSelected = false
    var membershipSelected = false
    
    //handles ads
    func createAndLoadInterstitial() -> GADInterstitial {
        //let interstitial = GADInterstitial(adUnitID: "ca-app-pub-3940256099942544/4411468910")
        let interstitial = GADInterstitial(adUnitID: "ca-app-pub-3329292800278297/4704789006")
        interstitial.delegate = self
        interstitial.load(GADRequest())
        return interstitial
    }
    
    func interstitialDidDismissScreen(_ ad: GADInterstitial) {
        interstitial = createAndLoadInterstitial()
        self.performSegue(withIdentifier: "unwindToTabSegue", sender: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        interstitial = createAndLoadInterstitial()
        ref = Database.database().reference()
        //sets up delegates
        parkNameTextField.delegate = self
        numCourtsTextField.delegate = self
        addressTextField.delegate = self
        //initializes switch states
        indoorSwitch.isOn = false
        membershipSwitch.isOn = false
        updateDoneButtonState()
    }
    
    //makes sure that park name and numcourts have proper values
    private func updateDoneButtonState(){
        var check = true
        startHoopingButton.isEnabled = false
        
        parkName = parkNameTextField.text ?? ""
        address = addressTextField.text ?? ""
        numCourts = numCourtsTextField.text ?? ""
        
        if (parkName == "" || numCourts == "" || !CharacterSet(charactersIn: "1234567890").isSuperset(of: CharacterSet(charactersIn: numCourts)) || numCourts.trimmingCharacters(in: .whitespacesAndNewlines) == "0"){
            check = false
            return
        }
        
        if parkName.isEmpty{
            check = false
            return
        } else if (parkName.count > 30 || parkName.count < 5){
            let alert = UIAlertController(title: "Error", message: "The parkname must be between 5 and 30 characters in length.", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Retry", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            check = false
            return
        }
        
        if !numCourts.isEmpty{
            if(Int(numCourts)! > 10){
                let alert = UIAlertController(title: "Error", message: "Sorry, one park cannot have more than 10 courts", preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "Continue", style: UIAlertAction.Style.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                check = false
                return
            }
        }
        
//        if address.isEmpty{
//            check = false
//            return
//        } else if (address != " "){
//            if (address.count > 40 || address.count < 5){
//                let alert = UIAlertController(title: "Error", message: "The address must be between 5 and 40 characters in length.", preferredStyle: UIAlertController.Style.alert)
//                alert.addAction(UIAlertAction(title: "Retry", style: UIAlertAction.Style.default, handler: nil))
//                self.present(alert, animated: true, completion: nil)
//                check = false
//                return
//            }
//        }
        startHoopingButton.isEnabled = check
    }
    
    //updates values when text field is done being edited
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
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        startHoopingButton.isEnabled = false
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
           // Hide the keyboard.
           textField.resignFirstResponder()
           return true
       }
    
    //checks if indoor switch is toggled and sets indoorselected accordingly
    @IBAction func indoorSwitchToggled(_ sender: UISwitch) {
        if (sender.isOn){
            indoorSelected = true
        } else {
            indoorSelected = false
        }
    }
    
    //checks if membership switch is toggled and sets membershipselected accordingly
    @IBAction func membershipSwitchToggled(_ sender: UISwitch) {
        if (sender.isOn){
            membershipSelected = true
        } else {
            membershipSelected = false
        }
    }
    
    //makes sure that ad is ready when the user creates the court
    @IBAction func startHoopingBtnPressed(_ sender: UIButton) {
        if interstitial.isReady {
            interstitial.present(fromRootViewController: self)
        } else {
            print("Ad wasn't ready.")
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        //adds court to database
        self.ref.child("Parks").childByAutoId().setValue(["coordinateslat": coordinates!.latitude,"coordinateslong":coordinates!.longitude,"parkname":self.parkName,"numcourts":Int(self.numCourts)!, "Address":self.address, "indoor":self.indoorSelected, "membership":self.membershipSelected])
        
        //resets values after added to database
        parkNameTextField.text = ""
        numCourtsTextField.text = ""
        addressTextField.text = ""
        membershipSwitch.isOn = false
        indoorSwitch.isOn = false
    }
 
}

