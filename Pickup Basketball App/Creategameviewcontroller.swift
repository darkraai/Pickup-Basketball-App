//
//  Creategameviewcontroller.swift
//  Pickup Basketball App
//
//  Created by Surya Mamidyala on 4/17/20.
//  Copyright © 2020 Hoop Break. All rights reserved.
//

import UIKit
import FirebaseDatabase
import GoogleMobileAds

class Creategameviewcontroller: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate, UITextFieldDelegate, GADInterstitialDelegate {

    var user24:User?
    
    var currentslots:[Game] = []
    
    var chosencourt:Court?
    
    var courtkey = ""
    
    var ref:DatabaseReference?
    
    var ref2:DatabaseReference?
    
    var interstitial: GADInterstitial!
    
    var creatorsandtimesofgames:[String] = []
    
    var iscreatorerror:Bool = false

    
    @IBOutlet weak var timeTextField: UITextField!
    @IBOutlet weak var gameModePicker: UIPickerView!
    @IBOutlet weak var bringBallToggle: UISwitch!
    @IBOutlet weak var startHoopingButton: UIButton!
    
    
    let gameModes = [" ", "1 v 1", "2 v 2", "3 v 3", "4 v 4", "5 v 5"]
    let timeModes = [" ", "6 am - 7 am", "7 am - 8 am", "8 am - 9 am", "9 am - 10 am", "10 am - 11 am","11 am - 12 pm","12 pm - 1 pm","1 pm - 2 pm","2 pm - 3 pm","3 pm - 4 pm","4 pm - 5 pm","5 pm - 6 pm","6 pm - 7 pm","7 pm - 8 pm","8 pm - 9 pm","9 pm - 10 pm","10 pm - 11 pm","11 pm - 12 am"]

    
    var selectedGameMode = " "
    var selectedTimeSlot = " "
    var selectedTimeSlotProc = " "
    
    //needed to decide which date to add the new cell
    var selecteddate = ""
    var todaysdate = ""
    
 
    var bringBall = true
    var publicValue = true
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    //configures number of pickerview rows for both gametypes and times
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
            if (pickerView.tag == 4){
                return gameModes.count
        }
        return timeModes.count

    }
    
    
    
    //configures titles of pickerview rows for both gametypes and times
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if (pickerView.tag == 4){
            return gameModes[row]
        }
        return timeModes[row]
    }
    
    //saves selected value when row is selected
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if (pickerView.tag == 4){
            selectedGameMode = gameModes[row]
        }
        else{
            selectedTimeSlot = timeModes[row]
        }
        
        updateDoneButtonState()
    }
    
    var activeTextField: UITextField!
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
         activeTextField = textField
    }
    
    let datePicker = UIPickerView()
    
    
    //configures the date picker
    private func createDatePicker(forField field : UITextField){
        field.textAlignment = .center
        
        //toolbar
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        //done bar button on toolbar
        let doneBtn = UIBarButtonItem(barButtonSystemItem: .done
            , target: nil, action: #selector(donePressed))
        
        toolbar.setItems([doneBtn], animated: true)
        
        //assign toolbar
        field.inputAccessoryView = toolbar
        
        //assign date picker to text field
        field.inputView = datePicker
        
    }
    //adds created game to database
    func addgametodatabase(){
        ref = Database.database().reference()
        ref2 = Database.database().reference().child("Parks")

        
        ref2?.observeSingleEvent(of: DataEventType.value, with: {(snapshot) in
            if snapshot.childrenCount > 0{
                for courts in snapshot.children.allObjects as![DataSnapshot]{
                    let courtobject = courts.value as? [String:AnyObject]
                    let parkname = courtobject?["parkname"]
                    let lat = courtobject?["coordinateslat"]
                    let long = courtobject?["coordinateslong"]
                    
                    self.courtkey = courts.key
                    
                    if(((self.chosencourt!.coordinates!.latitude) == lat as! Double) && (self.chosencourt!.coordinates!.longitude == long as! Double) && (self.chosencourt!.parkname == parkname as! String)){
                        if(self.creatorsandtimesofgames.count>0){
                            for index in 0...(self.creatorsandtimesofgames.count-1){
                                // check if chosencourt timeslot and creators correspond to those in creatorsandtimesofgames
                                if((self.creatorsandtimesofgames[index] == self.user24!.username) && (self.creatorsandtimesofgames[index+1] == self.selectedTimeSlotProc)){
                                    self.iscreatorerror = true
                                    self.performSegue(withIdentifier: "unwindToMenuSegue", sender: self)

                                
                            }
                        }
                        }
                        if(self.iscreatorerror == false){
                            self.ref?.child("Games").childByAutoId().setValue(["timeslot":self.selectedTimeSlotProc, "gametype":self.selectedGameMode, "creator":self.user24!.username, "slotsfilled": 1,"date":self.selecteddate, "courtid":self.courtkey, "team 1": [self.user24!.username], "team 2": ["placeholder"]])
                            self.performSegue(withIdentifier: "unwindToMenuSegue", sender: self)
                        }
                            
                        
                    }
                }

            }
            
        })

    }
    //converts timeslot in pickerview to same format of the slots in gamemenu controller screen
    func converttimeslot(){
        if(selectedTimeSlot == "6 am - 7 am"){
            selectedTimeSlotProc = "6-7 am"
        }
        if(selectedTimeSlot == "7 am - 8 am"){
            selectedTimeSlotProc = "7-8 am"
        }
        if(selectedTimeSlot == "8 am - 9 am"){
            selectedTimeSlotProc = "8-9 am"
        }
        if(selectedTimeSlot == "9 am - 10 am"){
            selectedTimeSlotProc = "9-10 am"
        }
        if(selectedTimeSlot == "10 am - 11 am"){
            selectedTimeSlotProc = "10-11 am"
        }
        if(selectedTimeSlot == "11 am - 12 pm"){
            selectedTimeSlotProc = "11-12 pm"
        }
        if(selectedTimeSlot == "12 pm - 1 pm"){
            selectedTimeSlotProc = "12-1 pm"
        }
        if(selectedTimeSlot == "1 pm - 2 pm"){
            selectedTimeSlotProc = "1-2 pm"
        }
        if(selectedTimeSlot == "2 pm - 3 pm"){
            selectedTimeSlotProc = "2-3 pm"
        }
        if(selectedTimeSlot == "3 pm - 4 pm"){
            selectedTimeSlotProc = "3-4 pm"
        }
        if(selectedTimeSlot == "4 pm - 5 pm"){
            selectedTimeSlotProc = "4-5 pm"
        }
        if(selectedTimeSlot == "5 pm - 6 pm"){
            selectedTimeSlotProc = "5-6 pm"
        }
        if(selectedTimeSlot == "6 pm - 7 pm"){
            selectedTimeSlotProc = "6-7 pm"
        }
        if(selectedTimeSlot == "7 pm - 8 pm"){
            selectedTimeSlotProc = "7-8 pm"
        }
        if(selectedTimeSlot == "8 pm - 9 pm"){
            selectedTimeSlotProc = "8-9 pm"
        }
        if(selectedTimeSlot == "9 pm - 10 pm"){
            selectedTimeSlotProc = "9-10 pm"
        }
        if(selectedTimeSlot == "10 pm - 11 pm"){
            selectedTimeSlotProc = "10-11 pm"
        }
        if(selectedTimeSlot == "11 pm - 12 am"){
            selectedTimeSlotProc = "11-12 am"
        }

    }

    @objc private func donePressed(){
        //formatter
        let formatter = DateFormatter()
        formatter.dateStyle = .none
        formatter.timeStyle = .short
        
        
        timeTextField.text = selectedTimeSlot

        self.view.endEditing(true)
        updateDoneButtonState()
    }
    
    //configures pickers and disables done button
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(self.creatorsandtimesofgames.count)
        
        interstitial = createAndLoadInterstitial()
        
        gameModePicker.delegate = self
        gameModePicker.dataSource = self
        timeTextField.delegate = self
        
        datePicker.delegate = self
        updateDoneButtonState()
        self.createDatePicker(forField: timeTextField)
    }
    
    func createAndLoadInterstitial() -> GADInterstitial {
        var interstitial = GADInterstitial(adUnitID: "ca-app-pub-3940256099942544/4411468910")
        interstitial.delegate = self
        interstitial.load(GADRequest())
        return interstitial
    }
    func interstitialDidDismissScreen(_ ad: GADInterstitial) {
        interstitial = createAndLoadInterstitial()
        
        converttimeslot()

        addgametodatabase()

    }
    
    //makes sure that done can only be pressed if certain conditions are met
    private func updateDoneButtonState(){
        startHoopingButton.isEnabled = false
        
        if (selectedGameMode != " " && selectedTimeSlot != " "){
            startHoopingButton.isEnabled = true

        }
        
    }
    
    //checks if the two switches are selected
    @IBAction func publicSwitchToggled(_ sender: UISwitch) {
        if (sender.isOn){
            publicValue = true
        }else{
            publicValue = false
        }
    }
    
    @IBAction func bringBallSwitchToggled(_ sender: UISwitch) {
        if (sender.isOn){
            bringBall = true
        }
        else{
            bringBall = false
        }
    }
    

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if(iscreatorerror == true){
            let alert = UIAlertController(title: "Error", message: "Sorry, you cannot create two games at the same time", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Continue", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        else{
        var counter = 0
        for z in currentslots{
            if(selectedTimeSlotProc == z.timeslot){
                counter+=1
            }
        }

        
        if(counter < chosencourt!.numcourts){
        let destinationViewController = segue.destination

        if let MainVC = destinationViewController as? Gamemenuviewcontroller{
            
            MainVC.alltimeslots.append(Game(timeslot: selectedTimeSlotProc, gametype: selectedGameMode, creator: user24!.username, slotsfilled: 1, team1: [user24!.username], team2: [], date: selecteddate, courtid: "")!)
                        

            MainVC.currenttimeslots.append(Game(timeslot: selectedTimeSlotProc, gametype: selectedGameMode, creator: user24!.username, slotsfilled: 1, team1: [user24!.username], team2: [], date: selecteddate, courtid: "")!)
            
        }
        }
        else{
            let alert = UIAlertController(title: "Error", message: "Sorry, All courts are already booked for this time slot", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Done", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        }
    }
    
    @IBAction func startHoopingBtnPressed(_ sender: Any) {
        iscreatorerror = false
        if interstitial.isReady {
            interstitial.present(fromRootViewController: self)

            
        } else {
            print("Ad wasn't ready.")
        }
        

    }
    
}
