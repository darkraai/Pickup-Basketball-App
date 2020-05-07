//
//  Creategameviewcontroller.swift
//  Pickup Basketball App
//
//  Created by Surya Mamidyala on 4/17/20.
//  Copyright © 2020 Hoop Break. All rights reserved.
//

import UIKit

class Creategameviewcontroller: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate, UITextFieldDelegate {

    
    @IBOutlet weak var timeTextField: UITextField!
    @IBOutlet weak var gameModePicker: UIPickerView!
    @IBOutlet weak var bringBallToggle: UISwitch!
    @IBOutlet weak var startHoopingButton: UIButton!
    
    let gameModes = [" ", "1 v 1", "2 v 2", "3 v 3", "4 v 4", "5 v 5"]
    let timeModes = [" ", "6 am - 7 am", "7 am - 8 am", "8 am - 9 am", "9 am - 10 am", "10 am - 11 am","11 am - 12 pm","12 pm - 1 pm","1 pm - 2 pm","2 pm - 3 pm","3 pm - 4 pm","4 pm - 5 pm","5 pm - 6 pm","6 pm - 7 pm","7 pm - 8 pm","8 pm - 9 pm","9 pm - 10 pm","10 pm - 11 pm","11 pm - 12 am"]

    
    var selectedGameMode = " "
    var selectedTimeSlot = " "
 
    var bringBall = true
    var publicValue = true
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
            if (pickerView.tag == 4){
                return gameModes.count
        }
        return timeModes.count

    }
    
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if (pickerView.tag == 4){
            return gameModes[row]
        }
        return timeModes[row]
    }
    
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
    
    
    @objc private func donePressed(){
        //formatter
        let formatter = DateFormatter()
        formatter.dateStyle = .none
        formatter.timeStyle = .short
        
        
        timeTextField.text = selectedTimeSlot

        self.view.endEditing(true)
        updateDoneButtonState()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        gameModePicker.delegate = self
        gameModePicker.dataSource = self
        timeTextField.delegate = self
        
        datePicker.delegate = self
        updateDoneButtonState()
        self.createDatePicker(forField: timeTextField)
    }
    
    private func updateDoneButtonState(){
        startHoopingButton.isEnabled = false
        print("selectedgamemode"+selectedGameMode)
        if (selectedGameMode != " " && selectedTimeSlot != " "){
            startHoopingButton.isEnabled = true

        }
        
    }
    
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
    }


}
