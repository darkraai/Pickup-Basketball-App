//
//  Gamemenuviewcontroller.swift
//  Pickup Basketball App
//
//  Created by Surya Mamidyala on 4/14/20.
//  Copyright © 2020 Hoop Break. All rights reserved.
//

import UIKit
import FirebaseDatabase
import MapKit

class Gamemenuviewcontroller: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {
    
    var user24:User?

    
    @IBOutlet weak var gamemenunavbar: UINavigationItem!
    @IBOutlet weak var gamemenutableview: UITableView!
    @IBOutlet weak var dateTextField: UITextField!
    
    var chosencourt: Court?
    
    var chosengameid: String?
    
    var totalslotsx:Int = 0
    
    var chosengame: Game?
    
    var chosengamestatus: String?
    
    var alltimeslotsids:[String] = []
    
    var chosenteam1:[User] = []
    
    var chosenteam2:[User] = []
    
    var hasuserjoined = false
    
    var user24team:String?
    
    var buttondistinguisher:Int?
    
    var ref:DatabaseReference?
    
    var refgame:DatabaseReference?
    
    var timeslotforalert: String?
    
    var courtnameforalert: String?
    
    var ProfilePic: UIImage?
    
    var creatorsandtimesofgames:[String] = []


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
    
    
    
    
    @IBAction func creategamepressed(_ sender: Any) {
        performSegue(withIdentifier: "create_game_segue", sender: self)
    }
    
    var todaysdate = ""
    
    var alltimeslots:[Game] = []
    var currenttimeslots:[Game] = []
    
    let datePicker = UIDatePicker()
    
    //formatter created
    let formatter = DateFormatter()

    //determines what a games button should be
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
    
    //sets the number of rows
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currenttimeslots.count
    }
    
    //creates each tableview cell and sets its properties
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
            
        }
        
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
    
    @IBAction func unwindToMenu(segue: UIStoryboardSegue) {}
    
    //sets up tableview and date picker stuff
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
        loadgames()
        gamemenunavbar.title = chosencourt!.parkname
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        gamemenutableview.reloadData()
        
    }
    

    

    //loads in games from the database into the tableview
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
            for x in self.alltimeslots{
                
                if(x.date! == self.dateTextField.text!){
                    self.currenttimeslots.append(x)
                }
            }
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
            MainVC.creatorsandtimesofgames = creatorsandtimesofgames

            
            for z in currenttimeslots{
                MainVC.currentslots.append(z)
            }
            
            MainVC.chosencourt = chosencourt
        }
        
        if let MainVC = destinationViewController as? Joingameviewcontroller{
            

                        
            MainVC.courtnameforalert = chosencourt!.parkname
            
            MainVC.timeslotforalert = timeslotforalert
            
            MainVC.user24 = user24
            
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
                    let userfirstname = user?["firstname"]
                    let userlastname = user?["lastname"]
                    let userusername = user?["username"]
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
                    
                 for x in team1{
                    if(x == userusername as! String){
                        if(x == self.user24!.username){
                            self.user24team = "team 1"
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
                        self.chosenteam2.append(User(firstname: userfirstname as! String, lastname: userlastname as! String, username: userusername as! String, password: userpassword as! String, userweight: userweight as! String, hometown: userhometown as! String, userheightinches: userheightinches as! String, userheightfeet: userheightfeet as! String, position: position as! String, profilepic: self.ProfilePic, pfplink: pfplink)!)
                   }
                   }

                }
            }
            self.performSegue(withIdentifier: "join_game_segue", sender: nil)
        })

        
        
        
        
        
    }
}
