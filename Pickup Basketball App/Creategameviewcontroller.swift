//
//  Creategameviewcontroller.swift
//  Pickup Basketball App
//
//  Created by Surya Mamidyala on 4/17/20.
//  Copyright © 2020 Hoop Break. All rights reserved.
//

import UIKit

class Creategameviewcontroller: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate, UITextFieldDelegate {

    
    @IBOutlet weak var startTimeTextField: UITextField!
    @IBOutlet weak var endTimeTextField: UITextField!
    @IBOutlet weak var gameModePicker: UIPickerView!
    @IBOutlet weak var bringBallToggle: UISwitch!
    @IBOutlet weak var startHoopingButton: UIButton!
    
    let gameModes = [" ", "1 v 1", "2 v 2", "3 v 3", "4 v 4", "5 v 5"]
   
    var selectedGameMode = ""
    var selectedStartTime = ""
    var selectedEndTime = ""
    var bringBall = true
    var publicValue = true
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
            return gameModes.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
            return gameModes[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedGameMode = gameModes[row]
        updateDoneButtonState()

    }
    
    var activeTextField: UITextField!
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
         activeTextField = textField
    }
    
    let datePicker = UIDatePicker()
    
    private func createDatePicker(forField field : UITextField){
        
        datePicker.datePickerMode = .time
        datePicker.minuteInterval = 30
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
    
    var startTimeTextFieldDate : Date?
    var endTimeTextFieldDate : Date?
    
    @objc private func donePressed(){
        //formatter
        let formatter = DateFormatter()
        formatter.dateStyle = .none
        formatter.timeStyle = .short
        
        if (activeTextField == startTimeTextField){
            startTimeTextField.text = formatter.string(from: datePicker.date)
            startTimeTextFieldDate = datePicker.date
            updateDoneButtonState()
        } else if (activeTextField == endTimeTextField){
            endTimeTextField.text = formatter.string(from: datePicker.date)
            endTimeTextFieldDate = datePicker.date
            updateDoneButtonState()
        }
        self.view.endEditing(true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        gameModePicker.delegate = self
        gameModePicker.dataSource = self
        startTimeTextField.delegate = self
        endTimeTextField.delegate = self
        
        updateDoneButtonState()
        self.createDatePicker(forField: startTimeTextField)
        self.createDatePicker(forField: endTimeTextField)
    }
    
    private func updateDoneButtonState(){
        startHoopingButton.isEnabled = false
        if (selectedGameMode != " " && endTimeTextFieldDate != nil && startTimeTextFieldDate != nil){
            if (endTimeTextFieldDate!.compare(startTimeTextFieldDate!) == ComparisonResult.orderedDescending){
                startHoopingButton.isEnabled = true
            }
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
