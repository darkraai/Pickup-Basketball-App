//
//  Gamemenuviewcontroller.swift
//  Pickup Basketball App
//
//  Created by Surya Mamidyala on 4/14/20.
//  Copyright © 2020 Hoop Break. All rights reserved.
//

import UIKit

class Gamemenuviewcontroller: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {
    
    
    @IBOutlet weak var dateTextField: UITextField!
    
    var timeData: [String] = ["1 - 2 pm", "2 - 3 pm", "3 - 4 pm"]
    var gameData: [String] = ["5 v 5", "5 v 5", "N/A"]
    var ownerData: [String] = ["@Bensvo", "@Sundar", "N/A"]
    var slotsFilledData : [String] = ["8/10", "6/6", ""]
    var buttonData : [String] = ["Join", "Full", "Create"]
    
    let datePicker = UIDatePicker()
    
    private func createDatePicker(forField field: UITextField){
        datePicker.datePickerMode = .date
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
    
    var dateTextFieldDate : Date?
    
    @objc private func donePressed(){
        //formatter
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none

        dateTextField.text = formatter.string(from: datePicker.date)
        dateTextFieldDate = datePicker.date
        
        self.view.endEditing(true)
    }
    
     
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return timeData.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "GameTableViewCell") as! GameTableViewCell

        cell.timeLabel.text = timeData[indexPath.row]
        cell.gameLabel.text = gameData[indexPath.row]
        cell.ownerLabel.text = ownerData[indexPath.row]
        cell.slotsFilledLabel.text = slotsFilledData[indexPath.row]
        cell.gameStatusButton.layer.cornerRadius = 5
        cell.gameStatusButton.setTitleColor(UIColor.white, for: .normal)
        cell.gameStatusButton.setTitle(buttonData[indexPath.row], for: .normal)
        if cell.gameStatusButton.currentTitle == "Join" {
            cell.gameStatusButton.backgroundColor = UIColor.green
        } else if cell.gameStatusButton.currentTitle == "Create" {
            cell.gameStatusButton.backgroundColor = UIColor.blue
        } else {
            cell.gameStatusButton.backgroundColor = UIColor.red
        }
        cell.gameStatusButton.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    @objc func buttonAction(sender: UIButton!) {
        if (sender.currentTitle == "Join" && dateTextField.text != ""){
               performSegue(withIdentifier: "join_game_segue", sender: self)
            }
        if (sender.currentTitle == "Create" && dateTextField.text != ""){
                performSegue(withIdentifier: "create_game_segue", sender: self)
            }
          
        }
    
    @IBAction func unwindToMenu(segue: UIStoryboardSegue) {}
    

    override func viewDidLoad() {
        super.viewDidLoad()
        dateTextField.delegate = self
        self.createDatePicker(forField: dateTextField)

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
