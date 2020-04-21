//
//  Editprofileviewcontroller.swift
//  Pickup Basketball App
//
//  Created by Ben Svoboda on 4/19/20.
//  Copyright © 2020 Hoop Break. All rights reserved.
//

import UIKit
import os.log


class Editprofileviewcontroller: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate {
    
    var user24:User?
    
    //textfields initialization
    @IBOutlet weak var editusername: UITextField!
    @IBOutlet weak var editpassword: UITextField!
    @IBOutlet weak var editfirst: UITextField!
    @IBOutlet weak var editlast: UITextField!
    @IBOutlet weak var editweight: UITextField!
    @IBOutlet weak var edithometown: UITextField!
    @IBOutlet weak var saveedits: UIBarButtonItem!
    
    
    //pickerview initialization
    @IBOutlet weak var heightfpv: UIPickerView!
    @IBOutlet weak var heightipv: UIPickerView!
    @IBOutlet weak var positionpv: UIPickerView!
    
    
    //these will be set to the picked value on pickerview
    var heightinfeet: String?
    var heightininches: String?
    var positions2: String?
    
    
    
    var heightfeet = [" ","4","5","6","7"]
    
    var heightinches = [" ","0","1","2","3","4","5","6","7","8","9","10","11"]
    
    var positions = [" ","PG","SG","SF","PF","C"]
    
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
        
       // updateDoneButtonState2()
        updateDoneButtonState3()

    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        editusername.text = user24?.username
        editpassword.text = user24?.password
        editfirst.text = user24?.firstname
        editlast.text = user24?.lastname
        editweight.text = user24?.userweight
        edithometown.text = user24?.hometown
        
        //text field delegates
        editusername.delegate = self
        editpassword.delegate = self
        editfirst.delegate = self
        editlast.delegate = self
        editweight.delegate = self
        edithometown.delegate = self
        
        
        //picker delegates and data sources
        self.heightfpv.delegate = self
        self.heightfpv.dataSource = self
        self.heightipv.delegate = self
        self.heightipv.dataSource = self
        self.positionpv.delegate = self
        self.positionpv.dataSource = self

        
        updateDoneButtonState3()

    }
    
    
    //MARK: UITextFieldDelegate
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
           // Hide the keyboard.
           textField.resignFirstResponder()
           return  true
       }
    
    //Disables the done button while the user is editing the text field
    func textFieldDidBeginEditing(_ textField: UITextField) {
        // Disable the Save button while editing.
        saveedits.isEnabled = false
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        //when done editing, updates save button state
        updateDoneButtonState3()
        //navigationItem.title = textField.text
    }
    
    private func updateDoneButtonState3() {
        // Disable the login button if the text field is empty.
        saveedits.isEnabled = false
    
        let userfirsttext = editfirst.text ?? ""
            
        let userlasttext = editlast.text ?? ""
            
        let usernametext = editusername.text ?? ""
            
        let userpasswordtext = editpassword.text ?? ""
            
        let userweighttext = editweight.text ?? ""
            
        let userhometowntext = edithometown.text ?? ""
            
        if((!userfirsttext.isEmpty)&&(!userlasttext.isEmpty)&&(!usernametext.isEmpty)&&(!userpasswordtext.isEmpty)&&(!userhometowntext.isEmpty) && (!userweighttext.isEmpty)&&(heightinfeet != nil)&&(heightinfeet != " ")&&(heightininches != nil)&&(heightininches != " ")&&(positions2 != nil)&&(positions2 != " ")&&(CharacterSet(charactersIn: "1234567890").isSuperset(of: CharacterSet(charactersIn: userweighttext)))){
                
                saveedits.isEnabled = true
            

            }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let destinationViewController = segue.destination as! BallerProfile
            destinationViewController.user24 = User(firstname: editfirst.text!, lastname: editlast.text!, username: editusername.text!, password: editpassword.text!, userweight: editweight.text!, hometown: edithometown.text!, userheightinches: heightininches!, userheightfeet: heightinfeet!, position: positions2!)
        }
        
    }
    



