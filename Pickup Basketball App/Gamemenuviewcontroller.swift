//
//  Gamemenuviewcontroller.swift
//  Pickup Basketball App
//
//  Created by Surya Mamidyala on 4/14/20.
//  Copyright © 2020 Hoop Break. All rights reserved.
//
//cleaned by bs

import UIKit
import FirebaseDatabase
import MapKit

class Gamemenuviewcontroller: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {
    
    var user24:User?

    
    @IBOutlet weak var gamemenunavbar: UINavigationItem!
    @IBOutlet weak var gamemenutableview: UITableView!
    @IBOutlet weak var dateTextField: UITextField!
    
    var datetonum:[String:Int] = ["6-7 am":1,"7-8 am":2,"8-9 am":3,"9-10 am":4,"10-11 am":5,"11-12 pm":6,"12-1 pm":7,"1-2 pm":8,"2-3 pm":9,"3-4 pm":10,"4-5 pm":11,"5-6 pm":12,"6-7 pm":13,"7-8 pm":14,"8-9 pm":15,"9-10 pm":16,"10-11 pm":17,"11-12 am":18]
    
    var chosencourt: Court? //court that was clicked on in home screen
    
    var chosengameid: String? //id of clicked court
    
    var totalslotsx:Int = 0
        
    var chosengamestatus: String?
    
    var alltimeslotsids:[String] = [] //array with time slot ids
    
    var chosenteam1:[User] = [] //array with users in team1
    
    var chosenteam2:[User] = [] //array with users in team2
    
    var hasuserjoined = false
    
    var user24team:String?
    
    var ref:DatabaseReference?
    
    var refgame:DatabaseReference?
    
    var timeslotforalert: String?
    
    var courtnameforalert: String?
    
    var ProfilePic: UIImage?
    
    var creatorsandtimesofgames:[String] = [] //string array of the person who created the game and its time
    
    var todaysdate = ""
    
    var alltimeslots:[Game] = [] //array with all games
    
    var currenttimeslots:[Game] = [] //array with current games
    
    let datePicker = UIDatePicker()
    
    //formatter created
    let formatter = DateFormatter()
    
    var dateTextFieldDate : Date?



    //opens maps and directs to court
    @IBAction func getDirectionsPressed(_ sender: UIButton) {
        
        //gets long and lat from chosencourt
        let latitude:CLLocationDegrees = (chosencourt?.coordinates!.latitude)!
        let longitude: CLLocationDegrees = (chosencourt?.coordinates!.longitude)!
        
        //regionDistance is the amount of distance on the map that should be shown
        let regionDistance:CLLocationDistance = 1000
        let coordinates = CLLocationCoordinate2DMake(latitude, longitude)
        let regionSpan = MKCoordinateRegion(center: coordinates, latitudinalMeters: regionDistance, longitudinalMeters: regionDistance)
        
        //specifications of what it should look like in the maps app
        let options = [MKLaunchOptionsMapCenterKey: NSValue(mkCoordinate: regionSpan.center), MKLaunchOptionsMapSpanKey: NSValue(mkCoordinateSpan: regionSpan.span)]
        
        //defines where final location is set
        let placemark = MKPlacemark(coordinate: coordinates)
        let mapItem = MKMapItem(placemark: placemark)
        
        //sets name in maps app
        mapItem.name = chosencourt?.parkname
        
        //actually launches the app
        mapItem.openInMaps(launchOptions: options)
        
    }
    
    
    
    //if create is pressed, goes to create game vc
    @IBAction func creategamepressed(_ sender: Any) {
        performSegue(withIdentifier: "create_game_segue", sender: self)
    }
    

    //determines what a games button status should be
    func determinebuttonstatus(curgame: Game) -> String{
        hasuserjoined = false
        for w in curgame.team1{
            if(user24!.username == w){
                hasuserjoined = true
            }
        }
        
        for z in curgame.team2{
            if(user24!.username == z){
                hasuserjoined = true
            }
        }
        if(hasuserjoined == true){
            return "Joined"
        }
        
        else if((curgame.totalslots != curgame.slotsfilled) && (curgame.totalslots != 0)){
            return "Join"
        }
        else if((curgame.totalslots == curgame.slotsfilled) && (curgame.totalslots != 0)){
            return "Full"
        }
        
        return "Joined"

    }
    
    //determines the total # of slots from gametype
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
    
    //creates date picker in the text field
    private func createDatePicker(forField field: UITextField){
        
        //sets the date picker to the current date
        datePicker.datePickerMode = .date
        field.textAlignment = .center
        datePicker.preferredDatePickerStyle = .wheels
        
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
    
    
    //sets the number of rows in the game menu
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.currenttimeslots.count == 0 {
            self.gamemenutableview.setEmptyMessage("No games currently scheduled")
        } else {
            self.gamemenutableview.restore()
        }
        return currenttimeslots.count
    }
    
    //creates each tableview (game) cell and sets its properties
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "GameTableViewCell") as! GameTableViewCell
        
        cell.gameStatusButton.isEnabled = true
        //configures each cell in the game menu
        if(dateTextField.text! == currenttimeslots[indexPath.row].date!){
            cell.timeLabel.text = currenttimeslots[indexPath.row].timeslot
            cell.gameLabel.text = currenttimeslots[indexPath.row].gametype
            cell.ownerLabel.text = currenttimeslots[indexPath.row].creator
            cell.slotsFilledLabel.text = String(currenttimeslots[indexPath.row].slotsfilled) + "/" + String(determinetotslots(curgame: currenttimeslots[indexPath.row])) //sets slotsFilled label to # of slots filled in the game divided by total # of slots available for the game
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
              
        }
        //used later to make sure that one person doesn't create 2 games at the same time
        creatorsandtimesofgames.append(cell.ownerLabel.text!)
        creatorsandtimesofgames.append(cell.timeLabel.text!)

        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        true
    }
    
    
    @objc func buttonAction(sender: UIButton!) {
        
    }
    
    //when used on other screens, unwinds to this one
    
    @IBAction func unwindToMenu(segue: UIStoryboardSegue) {
        self.currenttimeslots = self.currenttimeslots.sorted {self.datetonum[$0.timeslot]! < self.datetonum[$1.timeslot]!}
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //sets up tableview delegate and datasource
        gamemenutableview.delegate = self
        gamemenutableview.dataSource = self
        dateTextField.delegate = self
        //sets up datepicker
        self.createDatePicker(forField: dateTextField)
        datePicker.setDate(Date(), animated: false)
        formatter.dateStyle = .medium
        dateTextField.text = formatter.string(from: Date())
        todaysdate = dateTextField.text!
        loadgames()
        //sets the game menu title to park name
        gamemenunavbar.title = chosencourt!.parkname
        
        
    }
    //adds games found in loadgames
    override func viewWillAppear(_ animated: Bool) {
        creatorsandtimesofgames.removeAll()

        gamemenutableview.reloadData()
        
    }
    

    //loads in games from the database into the alltimeslots
    func loadgames(){
        ref = Database.database().reference().child("Games")
        ref?.observeSingleEvent(of: DataEventType.value, with: { (snapshot) in
            
            if snapshot.childrenCount > 0{
                for courts in snapshot.children.allObjects as![DataSnapshot]{
                    
                    var counter = 0
                    let gameobject = courts.value as? [String:AnyObject]
                    let courtid = gameobject?["courtid"]
                    let creator = gameobject?["creator"]
                    let date = gameobject?["date"]
                    let gametype = gameobject?["gametype"]
                    _ = gameobject?["slotsfilled"]
                    let team1 = gameobject?["team 1"] as! [String]
                    let team2 = gameobject?["team 2"] as! [String]
                    let timeslot = gameobject?["timeslot"]
                    let key = courts.key
                    
                    
                    
                    for _ in team1{
                        counter+=1
                    }
                    
                    for b in team2{
                        if(b != "placeholder"){
                            counter+=1
                        }
                    }
                    
                    if(courtid as! String == self.chosencourt!.courtid){
                        self.alltimeslots.append(Game(timeslot: timeslot as! String, gametype: gametype as! String, creator: creator as! String, slotsfilled: counter, team1: team1, team2: team2, date: date as! String, courtid: courtid as! String)!)
                        self.alltimeslotsids.append(key)
                    }

                }
            }
            //if the game in alltimeslots is of the correct date, it's added to current timeslots
            for x in self.alltimeslots{
                
                if(x.date! == self.dateTextField.text!){
                    self.currenttimeslots.append(x)
                }
            }
            self.currenttimeslots = self.currenttimeslots.sorted {self.datetonum[$0.timeslot]! < self.datetonum[$1.timeslot]!}
            self.gamemenutableview.reloadData()

        })


        
    }
    
    
    //when the date is changed, the game menu is updated accordingly
    @objc private func donePressed(){
        //formatter
        formatter.dateStyle = .medium
        formatter.timeStyle = .none

        dateTextField.text = formatter.string(from: datePicker.date)
        dateTextFieldDate = datePicker.date
        
        self.view.endEditing(true)
        
        currenttimeslots.removeAll()
        //adds every game that belongs to the newly selected date to currenttimeslots
        for x in alltimeslots{
            
            if(x.date! == dateTextField.text!){
                currenttimeslots.append(x)
            }
        }
        
        self.currenttimeslots = self.currenttimeslots.sorted {self.datetonum[$0.timeslot]! < self.datetonum[$1.timeslot]!}
        
        creatorsandtimesofgames.removeAll()
        
        gamemenutableview.reloadData()

    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let destinationViewController = segue.destination
        
        if let MainVC = destinationViewController as? Creategameviewcontroller{
            //sends necessary data to creategameviewcontroller
            
            MainVC.user24 = user24
            MainVC.selecteddate = dateTextField.text!
            creatorsandtimesofgames.append(dateTextField.text!)
            MainVC.creatorsandtimesofgames = creatorsandtimesofgames

            
            for z in currenttimeslots{
                MainVC.currentslots.append(z)
            }
            
            MainVC.chosencourt = chosencourt
        }
        
        if let MainVC = destinationViewController as? Joingameviewcontroller{
            
            //sends necessary data to joingameviewcontroller

            MainVC.courtnameforalert = chosencourt!.parkname
            
            MainVC.timeslotforalert = timeslotforalert
            
            MainVC.user24 = user24
            
            MainVC.todaysdate = dateTextField.text!
            
            MainVC.totalslots = totalslotsx
            
            MainVC.alltimeslotsids = alltimeslotsids
            
            MainVC.chosengamestatus = chosengamestatus
            
            MainVC.team1usersingame.removeAll()
            MainVC.team2usersingame.removeAll()
            
            MainVC.chosengameid = chosengameid

            MainVC.user24team = user24team
            
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
    
    func didtapbutton(timeslot: String, team1: [String], team2: [String], totalslots: Int, gameid: String, courtid: String, gamestat: UIButton) {

        chosengameid = gameid
        
        self.totalslotsx = totalslots

        self.chosenteam1.removeAll()
        self.chosenteam2.removeAll()
        

        
        chosengamestatus = gamestat.titleLabel!.text!
        
        timeslotforalert = timeslot
        
        

        refgame = Database.database().reference().child("Users")
        refgame?.observeSingleEvent(of: DataEventType.value, with: {(snapshot) in
            if snapshot.childrenCount > 0{
                for auser in snapshot.children.allObjects as![DataSnapshot]{
                    
                    let user = auser.value as? [String:AnyObject]
                    let userusername = user?["username"]
                    
                 for x in team1{
                    if(x == userusername as! String){
                        if(x == self.user24!.username){
                            self.user24team = "team 1"
                        }
                        
                        let userfirstname = user?["firstname"]
                        let userlastname = user?["lastname"]
                        let userpassword = user?["password"]
                        let userweight = user?["weight"]
                        let userhometown = user?["hometown"]
                        let userheightinches = user?["heightinches"]
                        let userheightfeet = user?["heightfeet"]
                        let position = user?["position"]
                        let pfplink = user?["pfp"] as? String
                        
                        let url = URL(string:pfplink!)
                        do{
                            let data = try Data(contentsOf: url!)
                            self.ProfilePic = UIImage(data: data)
                        }catch _{
                            print("Error")
                        }
                        
                        self.chosenteam1.append(User(firstname: userfirstname as! String, lastname: userlastname as! String, username: userusername as! String, password: userpassword as! String, userweight: userweight as! String, hometown: userhometown as! String, userheightinches: userheightinches as! String, userheightfeet: userheightfeet as! String, position: position as! String, profilepic: self.ProfilePic, pfplink: pfplink)!)
                    }
                    
                    }

                for y in team2{
                    if (y == "placeholder"){
                    }
                   else if(y == userusername as! String){
                        if(y == self.user24!.username){
                            self.user24team = "team 2"
                        }
        
                        let userfirstname = user?["firstname"]
                        let userlastname = user?["lastname"]
                        let userpassword = user?["password"]
                        let userweight = user?["weight"]
                        let userhometown = user?["hometown"]
                        let userheightinches = user?["heightinches"]
                        let userheightfeet = user?["heightfeet"]
                        let position = user?["position"]
                        let pfplink = user?["pfp"] as? String
                        
                        let url = URL(string:pfplink!)
                        do{
                            let data = try Data(contentsOf: url!)
                            self.ProfilePic = UIImage(data: data)
                        }catch _{
                            print("Error")
                        }
                        
                        self.chosenteam2.append(User(firstname: userfirstname as! String, lastname: userlastname as! String, username: userusername as! String, password: userpassword as! String, userweight: userweight as! String, hometown: userhometown as! String, userheightinches: userheightinches as! String, userheightfeet: userheightfeet as! String, position: position as! String, profilepic: self.ProfilePic, pfplink: pfplink)!)
                   }
                   }

                }
            }
            self.performSegue(withIdentifier: "join_game_segue", sender: nil)
        })

        
        
        
        
        
    }
}

extension UITableView {

    func setEmptyMessage(_ message: String) {
        let messageLabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.bounds.size.width, height: self.bounds.size.height))
        messageLabel.text = message
        messageLabel.textColor = .darkGray
        messageLabel.numberOfLines = 0
        messageLabel.textAlignment = .center
        messageLabel.font = UIFont.systemFont(ofSize: 35, weight: .light)
        messageLabel.sizeToFit()

        self.backgroundView = messageLabel
        self.separatorStyle = .none
    }

    func restore() {
        self.backgroundView = nil
        self.separatorStyle = .singleLine
    }
}
