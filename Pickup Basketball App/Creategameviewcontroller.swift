//
//  Creategameviewcontroller.swift
//  Pickup Basketball App
//
//  Created by Surya Mamidyala on 4/17/20.
//  Copyright © 2020 Hoop Break. All rights reserved.
//

import UIKit

class Creategameviewcontroller: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {

    @IBOutlet weak var startTimePicker: UIDatePicker!
    @IBOutlet weak var endTimePicker: UIDatePicker!
    @IBOutlet weak var gameModePicker: UIPickerView!
    @IBOutlet weak var publicToggle: UISwitch!
    @IBOutlet weak var bringBallToggle: UISwitch!
    @IBOutlet weak var startHoopingButton: UIButton!
    
    let gameModes = ["1 v 1", "2 v 2", "3 v 3", "4 v 4", "5 v 5"]
   
    var selectedGameMode = ""
    var selectedStartTime = ""
    var selectedEndTime = ""
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        gameModePicker.delegate = self
        gameModePicker.dataSource = self
        
        updateDoneButtonState()
    }
    
    private func updateDoneButtonState(){
        startHoopingButton.isEnabled = false
        if (selectedGameMode != ""){
            startHoopingButton.isEnabled = true
        }
        
    }
    


    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }


}
