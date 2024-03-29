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
    
    //Users that will be loaded in irl
    var userayush = User(firstname: "Ayush", lastname: "Hariharan", username: "ayushluvshali", password: "fjwei", userweight: "160", hometown: "boo", userheightinches: "9", userheightfeet: "5", position: "SG", profilepic: UIImage(named: "ayush")!)
    var usersurya = User(firstname: "Surya", lastname: "Mamidyala", username: "suryam", password: "jfwoef", userweight: "105", hometown: "jfwe", userheightinches: "11", userheightfeet: "5", position: "SF", profilepic: UIImage(named: "surya")!)
    var useryash = User(firstname: "Yash", lastname: "Halal", username: "sirhalalyash", password: "fjwofej", userweight: "300", hometown: "pakistan", userheightinches: "4", userheightfeet: "4", position: "C", profilepic: UIImage(named: "yashipoo")!)
    var userben = User(firstname: "Ben", lastname: "Svoboda", username: "bensvo", password: "jfoewj", userweight: "215", hometown: "jfweo", userheightinches: "3", userheightfeet: "6", position: "PG", profilepic: UIImage(named: "ben")!)
    var userbik = User(firstname: "Bikram", lastname: "Kohli", username: "lightskinb", password: "fjwe", userweight: "190", hometown: "fjwof", userheightinches: "3", userheightfeet: "6", position: "SF", profilepic: UIImage(named: "bik")!)
    var userxan = User(firstname: "Xan", lastname: "Manshoota", username: "xanmanshoota", password: "fjwe", userweight: "190", hometown: "fjwof", userheightinches: "3", userheightfeet: "6", position: "SF", profilepic: UIImage(named: "xanman")!)
    var usertrey = User(firstname: "Trey", lastname: "Watts", username: "treyvonsteals", password: "fjwe", userweight: "190", hometown: "fjwof", userheightinches: "3", userheightfeet: "6", position: "SF", profilepic: UIImage(named: "trey")!)
    var userawal = User(firstname: "Awal", lastname: "Awal", username: "awaldasnipa", password: "fjwe", userweight: "190", hometown: "fjwof", userheightinches: "3", userheightfeet: "6", position: "SF", profilepic: UIImage(named: "aryan")!)
    
    
    
    
    //timeslots that will be loaded in irl
    lazy var timeslot1 = Game(timeslot: "1-2 pm", gametype: "5 v 5", creator: userben!.username, slotsfilled: 8, team1: [userayush!,usersurya!,useryash!], team2: [userben!,userbik!,userxan!,usertrey!,userawal!],date: "04 May 2020")
    
    lazy var timeslot2 = Game(timeslot: "2-3 pm", gametype: "3 v 3", creator: usersurya!.username, slotsfilled: 6, team1: [userayush!,usersurya!,useryash!], team2: [userben!,userbik!,userxan!],date: "04 May 2020")
    
    lazy var alltimeslots = [timeslot1,timeslot2]
    
    lazy var timeData: [String] = ["6-7 am", "7-8 am", "8-9 am","9-10 am","10-11 am", "11-12 pm","12-1 pm","1-2 pm","2-3 pm", "3-4 pm", "4-5 pm", "5-6 pm", "6-7 pm", "7-8 pm", "8-9 pm", "9-10 pm", "10-11 pm"]
    lazy var gameData: [String] = ["","","","","","","",timeslot1!.gametype!, timeslot2!.gametype!, "","","","","","","",""]
    lazy var ownerData: [String] = ["","","","","","","",timeslot1!.creator!, timeslot2!.creator!, "","","","","","","",""]
    lazy var slotsFilledData : [String] = ["","","","","","","",String(timeslot1!.slotsfilled)+"/" + String(determinetotslots(curgame: timeslot1!)), String(timeslot2!.slotsfilled) + "/" + String(determinetotslots(curgame: timeslot2!)), "","","","","","","",""]
    
    lazy var buttonData : [String] = ["Create","Create","Create","Create","Create","Create","Create",determinebuttonstatus(curgame: timeslot1!), determinebuttonstatus(curgame: timeslot2!), "Create","Create","Create","Create","Create","Create","Create","Create"]
    
    var gamesOnDayMay42020 : Game = []
    var gamesOnDayJune42020 : Game = []
    var gamesOnDayJuly42020 : Game = []
    
    let datePicker = UIDatePicker()
    
    //formatter created
    let formatter = DateFormatter()

    func determinebuttonstatus(curgame: Game) -> String{
        if((curgame.totalslots != curgame.slotsfilled) && (curgame.totalslots != 0)){
            return "Join"
        }
        else if((curgame.totalslots == curgame.slotsfilled) && (curgame.totalslots != 0)){
            return "Full"
        }
        else{
            return "Create"
        }
    }
    
    func determinetotslots(curgame: Game) -> Int{
        if(curgame.gametype == "5 v 5"){
            curgame.totalslots = 10
            return 10
        }
        else if(curgame.gametype == "4 v 4"){
            curgame.totalslots = 8
            return 8
        }
        else if(curgame.gametype == "3 v 3"){
            curgame.totalslots = 6
            return 6
        }
        else if(curgame.gametype == "2 v 2"){
            curgame.totalslots = 4
            return 4
        }
        else{
            curgame.totalslots = 2
            return 2

        }
    }
    
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
        
//        datePicker.datePickerMode = UIDatePicker.Mode.date
//        let dateFormatter = DateFormatter()
//        dateFormatter.dateFormat = "dd MMMM yyyy"
//        let selectedDate = dateFormatter.string(from: datePicker.date)
//        print(selectedDate)
//        print(timeslot1!.date!)
        
        
        cell.timeLabel.text = timeData[indexPath.row]
        cell.gameLabel.text = gameData[indexPath.row]
        cell.ownerLabel.text = ownerData[indexPath.row]
        cell.slotsFilledLabel.text = slotsFilledData[indexPath.row]
        cell.gameStatusButton.layer.cornerRadius = 5
        cell.gameStatusButton.setTitleColor(UIColor.white, for: .normal)
        cell.gameStatusButton.setTitle(buttonData[indexPath.row], for: .normal)
        if cell.gameStatusButton.currentTitle == "Join" {
            cell.gameStatusButton.backgroundColor = UIColor.systemGreen
        } else if cell.gameStatusButton.currentTitle == "Create" {
            cell.gameStatusButton.backgroundColor = UIColor.orange
        } else {
            cell.gameStatusButton.backgroundColor = UIColor.gray
        }
        cell.gameStatusButton.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        if (dateTextField.text == "Jun 4, 2020"){
            gamesOnDayJune42020.append(cell)
        }
        if (dateTextField.text == "May 4, 2020"){
            gamesOnDayMay42020.append(cell)
        }
        if (dateTextField.text == "July 4 2020"){
            gamesOnDayJuly42020.append(cell)
        }
        return cell

    }
    
    func loadData(){
        if (dateTextField.text == "Jun 4, 2020"){
            for index in 0..<timeData.count{
                var gameCell = GameTableViewCell()
                gameCell.timeLabel.text = timeData[index]
                gameCell.gameLabel.text = 
            }
        }
        if (dateTextField.text == "May 4, 2020"){
            
        }
        if (dateTextField.text == "July 4 2020"){
            
        }
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
        datePicker.setDate(Date(), animated: false)
        formatter.dateStyle = .medium
        dateTextField.text = formatter.string(from: Date())

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
