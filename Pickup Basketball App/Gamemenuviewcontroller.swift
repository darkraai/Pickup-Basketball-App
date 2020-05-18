//
//  Gamemenuviewcontroller.swift
//  Pickup Basketball App
//
//  Created by Surya Mamidyala on 4/14/20.
//  Copyright © 2020 Hoop Break. All rights reserved.
//

import UIKit

class Gamemenuviewcontroller: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {
    
    var user24:User?

    
    @IBOutlet weak var gamemenutableview: UITableView!
    @IBOutlet weak var dateTextField: UITextField!
    
    var chosencourt: Court!

    @IBAction func creategamepressed(_ sender: Any) {
        if user24?.hometown != "N/A"{
            performSegue(withIdentifier: "create_game_segue", sender: self)
        }
        else{
            print("Sorry you got to go the long (registration) way")
        }
    }
    
    var todaysdate = ""
    
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
    lazy var timeslot1 = Game(timeslot: "1-2 pm", gametype: "5 v 5", creator: userben!.username, slotsfilled: 8, team1: [userayush!,usersurya!,useryash!], team2: [userben!,userbik!,userxan!,usertrey!,userawal!],date: "May 18, 2020")
    

    lazy var timeslot2 = Game(timeslot: "2-3 pm", gametype: "3 v 3", creator: usersurya!.username, slotsfilled: 6, team1: [userayush!,usersurya!,useryash!], team2: [userben!,userbik!,userxan!],date: "May 19, 2020")
    
    lazy var timeslot3 = Game(timeslot: "10-11 am", gametype: "2 v 2", creator: userxan!.username, slotsfilled: 3, team1: [userayush!,usersurya!,useryash!], team2: [userben!,userbik!,userxan!],date: "May 19, 2020")
    
    lazy var timeslot4 = Game(timeslot: "3-4 pm", gametype: "3 v 3", creator: userbik!.username, slotsfilled: 4, team1: [userayush!,usersurya!,useryash!], team2: [userben!,userbik!,userxan!],date: "May 19, 2020")
    
    lazy var alltimeslots:[Game] = [timeslot1!,timeslot2!,timeslot3!,timeslot4!]
    lazy var currenttimeslots:[Game] = [timeslot1!]
    
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
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currenttimeslots.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "GameTableViewCell") as! GameTableViewCell
        


        if(dateTextField.text! == currenttimeslots[indexPath.row].date!){
            cell.timeLabel.text = currenttimeslots[indexPath.row].timeslot
            cell.gameLabel.text = currenttimeslots[indexPath.row].gametype
            cell.ownerLabel.text = currenttimeslots[indexPath.row].creator
            cell.slotsFilledLabel.text = String(currenttimeslots[indexPath.row].slotsfilled) + "/" + String(determinetotslots(curgame: currenttimeslots[indexPath.row]))
            cell.gameStatusButton.layer.cornerRadius = 5
            cell.gameStatusButton.setTitleColor(UIColor.white, for: .normal)
            cell.gameStatusButton.setTitle(String(determinebuttonstatus(curgame: currenttimeslots[indexPath.row])), for: .normal)
            if cell.gameStatusButton.currentTitle == "Join" {
                cell.gameStatusButton.backgroundColor = UIColor.systemGreen
            } else if cell.gameStatusButton.currentTitle == "Create" {
                cell.gameStatusButton.backgroundColor = UIColor.orange
            } else {
                cell.gameStatusButton.backgroundColor = UIColor.gray
            }
            cell.gameStatusButton.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        }
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        true
    }
    
    
    
    @objc func buttonAction(sender: UIButton!) {
        if (sender.currentTitle == "Join" && dateTextField.text != ""){
               if user24!.hometown != "N/A"{
                   performSegue(withIdentifier: "join_game_segue", sender: self)
               }
               else{
                   print("Sorry you got to go the long (registration) way")
               }
            }
          
        }
    
    @IBAction func unwindToMenu(segue: UIStoryboardSegue) {}
    

    override func viewDidLoad() {
        super.viewDidLoad()
        gamemenutableview.delegate = self
        gamemenutableview.dataSource = self
        dateTextField.delegate = self
        self.createDatePicker(forField: dateTextField)
        datePicker.setDate(Date(), animated: false)
        formatter.dateStyle = .medium
        dateTextField.text = formatter.string(from: Date())
        todaysdate = dateTextField.text!
        
        print(chosencourt.parkname)
        print(dateTextField.text!)


//        for x in alltimeslots{
//            if(x.date! == dateTextField.text!){
//                currenttimeslots.append(x)
//            }
//        }
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        gamemenutableview.reloadData()

    }
    
    @objc private func donePressed(){
        //formatter
        formatter.dateStyle = .medium
        formatter.timeStyle = .none

        dateTextField.text = formatter.string(from: datePicker.date)
        dateTextFieldDate = datePicker.date
        
        self.view.endEditing(true)
        
        currenttimeslots.removeAll()
        gamemenutableview.reloadData()
        //add for to do this
        for x in alltimeslots{
            if(x.date! == dateTextField.text!){
                currenttimeslots.append(x)
            }
        }

        gamemenutableview.reloadData()


    }
    

    


   
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let destinationViewController = segue.destination
        
        if let MainVC = destinationViewController as? Creategameviewcontroller{
            
            MainVC.user24 = user24
            MainVC.selecteddate = dateTextField.text!
            MainVC.todaysdate = todaysdate
        }
        

    }


}
