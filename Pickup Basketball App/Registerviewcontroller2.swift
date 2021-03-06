//
//  Registerviewcontroller2.swift
//  Pickup Basketball App
//
//  Created by Ben Svoboda on 4/6/20.
//cleaned by bs


import UIKit
import os.log
import FirebaseDatabase
import FirebaseStorage

class RegisterViewController2: UIViewController,UITextFieldDelegate, UIPickerViewDataSource, UIPickerViewDelegate {
    
    
    //MARK: Properties
    
    var ref: DatabaseReference!
    
    var metaImageURL: String? //url of image uploaded to firebase storage
    

    @IBOutlet weak var userweight: UITextField!
    @IBOutlet weak var userhometown: UITextField!
    @IBOutlet weak var registerdone: UIBarButtonItem!
    
    
    @IBOutlet weak var pickerviewheight: UIPickerView!
    @IBOutlet weak var pickerviewheight2: UIPickerView!
    @IBOutlet weak var pickerviewposition: UIPickerView!

    
    //properties to be retrieved from last vc
    var fname: String?
    var lname: String?
    var uname: String?
    var pword: String?
    
    
    var heightfeet = [" ","4","5","6","7"]
    
    var heightinches = [" ","0","1","2","3","4","5","6","7","8","9","10","11"]
    
    var positions = [" ","PG","SG","SF","PF","C"]


    var heightinfeet: String?
    var heightininches: String?
    var positions2: String?

    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        if pickerView.tag == 1{
            return heightfeet[row]
        }
        else if pickerView.tag == 3{
            return positions[row]
        }
        else{
            return heightinches[row]
        }
        
    }
    
    //determines number of rows in each pickerview
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        if pickerView.tag == 1{
            return heightfeet.count
        }
        else if pickerView.tag == 3{
            return positions.count
        }
        else{
            return heightinches.count
        }
    }
    
    //adjusts values based on what is selected on pickerview
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView.tag == 1{
            heightinfeet = heightfeet[row]
        }
        else if pickerView.tag == 3{
            positions2 = positions[row]
        }
        else{
            heightininches = heightinches[row]
        }
        
        updateDoneButtonState2()

    }
    
        
        override func viewDidLoad() {
            super.viewDidLoad()
            
            ref = Database.database().reference()
            
            
            
            userweight.delegate = self
            userhometown.delegate = self
  
            self.pickerviewheight.delegate = self
            self.pickerviewheight.dataSource = self
            self.pickerviewheight2.delegate = self
            self.pickerviewheight2.dataSource = self
            self.pickerviewposition.delegate = self
            self.pickerviewposition.dataSource = self
            
            let label = UILabel(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
            label.text = "LBS"
            label.textColor = UIColor(red: 65/255, green: 105/255, blue: 225/255, alpha: 1)
            label.textAlignment = .left
            userweight.rightView = label
            userweight.rightViewMode = .always
            
            updateDoneButtonState2()
    }
    

        
    

//sends data through tab bar and nav controllers
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //sets default profile picture
        let image14 = UIImage(named: "user")
        let imageData = image14!.jpegData(compressionQuality: 0.4)!
        
        let fullname = self.fname! + " " + self.lname!
        
        let storageRef = Storage.storage().reference(forURL: "gs://pickup-basketball-app.appspot.com")
        let storageProfileRef = storageRef.child("profile").child(uname!)
        
        let metadata = StorageMetadata()
        metadata.contentType = "image/jpg"
        
        //adds profile picture to database
        storageProfileRef.putData(imageData, metadata: metadata, completion:
            {(storageMetaData, error) in
            
                storageProfileRef.downloadURL(completion: {(url, error) in
                
                    if let metaImageURL = url?.absoluteString{
                        self.metaImageURL = metaImageURL
                        self.ref.child("Users").child(self.uname!).setValue(["firstname":self.fname!, "lastname":self.lname!, "password":self.pword!,"weight":self.userweight.text!, "hometown":self.userhometown.text!,"heightfeet":self.heightinfeet!,"heightinches":self.heightininches!,"position":self.positions2!, "username":self.uname!, "fullname":fullname, "pfp":self.metaImageURL])
                    }
                
                })
            })
        //sets destination to tab bar controller
        let barViewControllers = segue.destination as! UITabBarController
        
        //depending which tab is clicked on the tab bar controller, the user is passed to that VC
        let navvc = barViewControllers.viewControllers![3] as! navballerprofile

        let finalvcbp = navvc.topViewController as! BallerProfile
        

        
        //sends the user object that was just made to the next vc
        finalvcbp.user24 = User(firstname: self.fname!, lastname: self.lname!, username: self.uname!, password: self.pword!, userweight: userweight.text!, hometown: userhometown.text!, userheightinches: heightininches!, userheightfeet: heightinfeet!, position: positions2!, profilepic: image14, pfplink: self.metaImageURL)

        
        let navh = barViewControllers.viewControllers![0] as! navhome
        
        let finalvch = navh.topViewController as! Homeviewcontroller
        
        
        finalvch.user24 = User(firstname: self.fname!, lastname: self.lname!, username: self.uname!, password: self.pword!, userweight: userweight.text!, hometown: userhometown.text!, userheightinches: heightininches!, userheightfeet: heightinfeet!, position: positions2!, profilepic: image14, pfplink: self.metaImageURL)
        
        let navs = barViewControllers.viewControllers![1] as! navsearch
        
        let finalvcs = navs.topViewController as! Searchviewcontroller
        
        finalvcs.user24 = User(firstname: self.fname!, lastname: self.lname!, username: self.uname!, password: self.pword!, userweight: userweight.text!, hometown: userhometown.text!, userheightinches: heightininches!, userheightfeet: heightinfeet!, position: positions2!, profilepic: image14, pfplink: self.metaImageURL)
        
        
        let navac = barViewControllers.viewControllers![2] as! navaddcourt
        
        let finalvcac = navac.topViewController as! Tabnewcourtviewcontroller
        
        finalvcac.user24 = User(firstname: self.fname!, lastname: self.lname!, username: self.uname!, password: self.pword!, userweight: userweight.text!, hometown: userhometown.text!, userheightinches: heightininches!, userheightfeet: heightinfeet!, position: positions2!, profilepic: image14, pfplink: self.metaImageURL)
        

    }
    
        
        //MARK: UITextFieldDelegate
        func textFieldShouldReturn(_ textField: UITextField) -> Bool {
               // Hide the keyboard.
               textField.resignFirstResponder()
               return true
           }
        
        //Disables the done button while the user is editing the text field
        func textFieldDidBeginEditing(_ textField: UITextField) {
            // Disable the Save button while editing.
            registerdone.isEnabled = false
        }
        
        func textFieldDidEndEditing(_ textField: UITextField) {
            //when done editing, updates save button state
            updateDoneButtonState2()
        }
        
        private func updateDoneButtonState2() {
            // Disable the register button to start
            registerdone.isEnabled = false
            
            let userweighttext = userweight.text ?? ""
            
            let userhometowntext = userhometown.text ?? ""
            
            var check = true
            
            //makes sure all fields are filled out
            if((!userhometowntext.isEmpty) && (!userweighttext.isEmpty)&&(heightinfeet != nil)&&(heightinfeet != " ")&&(heightininches != nil)&&(heightininches != " ")&&(positions2 != nil)&&(positions2 != " ")&&(CharacterSet(charactersIn: "1234567890").isSuperset(of: CharacterSet(charactersIn: userweighttext)))){
                
                check = true
            
            } else {
                check = false
                return
            }
            
            //makes sure the weight isn't over 3 digits
            if userweighttext.count > 3{
                let alert = UIAlertController(title: "Error", message: "Your weight must be between 1 and 3 characters in length.", preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "Retry", style: UIAlertAction.Style.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                check = false
                return
            //makes sure the hometown length isn't over 30 characters
            } else if userhometowntext.count > 30{
                let alert = UIAlertController(title: "Error", message: "Your hometown must be less than 30 characters in length. Please provide an abbreviated hometown.", preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "Retry", style: UIAlertAction.Style.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                check = false
                return
            }
            
            //enables or doesn't enable done button depending on what check is
            registerdone.isEnabled = check
        
        }
        
}
