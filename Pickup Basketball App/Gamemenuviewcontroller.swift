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
    
    var chosengameid: String?
    
    var totalslotsx:Int = 0
    
    var chosengame: Game?
    
    var chosenteam1:[User] = []
    
    var chosenteam2:[User] = []
    
    var selectedgameids:[String] = []

    var buttondistinguisher:Int?

    
    @IBAction func creategamepressed(_ sender: Any) {
        if user24?.hometown != "N/A"{
            performSegue(withIdentifier: "create_game_segue", sender: self)
        }
        else{
            print("Sorry you got to go the long (registration) way")
        }
    }
    
    var todaysdate = ""
    
    
    

    
    lazy var alltimeslots:[Game] = []
    lazy var currenttimeslots:[Game] = []
    
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
        
        return "Joined"

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
            } else if cell.gameStatusButton.currentTitle == "Joined" {
                cell.gameStatusButton.backgroundColor = UIColor.orange
            } else {
                cell.gameStatusButton.backgroundColor = UIColor.gray
                cell.gameStatusButton.isEnabled = false

            }
            cell.gameStatusButton.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
            cell.setGame(game: currenttimeslots[indexPath.row])
            cell.delegate = self
            
//            chosengameid = currenttimeslots[indexPath.row].timeslot + currenttimeslots[indexPath.row].gametype! + currenttimeslots[indexPath.row].creator!
//            for x in chosencourt.game!{
//                if(x.gameid == chosengameid!){
//                    chosengame = x
//                    print("success")
//                    print(chosengameid!)
//                    print(x.gameid)
//                }
//            }
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
//        if (sender.currentTitle == "Join" && dateTextField.text != ""){
//               if user24!.hometown != "N/A"{
//                
//                   performSegue(withIdentifier: "join_game_segue", sender: self)
//               }
//               else{
//                   print("Sorry you got to go the long (registration) way")
//               }
//            }
          
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
            
            for z in currenttimeslots{
                MainVC.currentslots.append(z)
            }
            MainVC.chosencourt = chosencourt
        }
        
        if let MainVC = destinationViewController as? Joingameviewcontroller{
            
            
            MainVC.user24 = user24
            
            MainVC.totalslots = totalslotsx
            
            
            MainVC.team1usersingame.removeAll()
            MainVC.team2usersingame.removeAll()

            
            for y in chosenteam1{
                MainVC.team1usersingame.append(y)
            }

            for z in chosenteam2{
                MainVC.team2usersingame.append(z)
            }
            
        }

    }


}
extension Gamemenuviewcontroller: delegate{
    
    func didtapbutton(timeslot: String, team1: [User], team2: [User], totalslots: Int, gameid: String) {

        totalslotsx = totalslots
        
        
        chosenteam1.removeAll()
        chosenteam2.removeAll()

            for x in team1{
                chosenteam1.append(x)
            }
            
            for z in team2{
                chosenteam2.append(z)
            }
        
        
        

        performSegue(withIdentifier: "join_game_segue", sender: nil)
    }
}
