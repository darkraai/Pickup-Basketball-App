//
//  Registerviewcontroller2.swift
//  Pickup Basketball App
//
//  Created by Ben Svoboda on 4/6/20.


import UIKit
import os.log



class RegisterViewController2: UIViewController,UITextFieldDelegate, UIPickerViewDataSource, UIPickerViewDelegate {
    
    
    //MARK: Properties
    //@IBOutlet weak var userheightf: UITextField!
    @IBOutlet weak var userweight: UITextField!
    @IBOutlet weak var userhometown: UITextField!
    @IBOutlet weak var registerdone: UIBarButtonItem!
    
    
    @IBOutlet weak var pickerviewheight: UIPickerView!
    @IBOutlet weak var pickerviewheight2: UIPickerView!
    @IBOutlet weak var pickerviewposition: UIPickerView!

    @IBOutlet weak var testLabel: UILabel!
    
    //properties to be retrieved from last slide
    var fname: String?
    var lname: String?
    var uname: String?
    var pword: String?
    
    
    
    let heightfeet = ["4","5","6","7"]
    
    let heightinches = ["0","1","2","3","4","5","6","7","8","9","10","11"]
    
    let positions = ["PG","SG","SF","PF","C"]


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
        
    }
    
        
        override func viewDidLoad() {
            super.viewDidLoad()
            // Do any additional setup after loading the view.
            //text fields
            userweight.delegate = self
            userhometown.delegate = self
            //pickers
            self.pickerviewheight.delegate = self
            self.pickerviewheight.dataSource = self
            self.pickerviewheight2.delegate = self
            self.pickerviewheight2.dataSource = self
            self.pickerviewposition.delegate = self
            self.pickerviewposition.dataSource = self
            
            testLabel.text = fname

            updateDoneButtonState2()

    }
        
    
    @IBAction func donetappedd(_ sender: Any) {
        print("hellodaddi")
        print (fname!, lname!, uname!, pword!, userweight.text!, userhometown.text!, heightinfeet!, heightininches!, positions2!)
        var user24 = User(firstname: fname!, lastname: lname!, username: uname!, password: pword!, userweight: userweight.text!, hometown: userhometown.text!, userheightinches: heightininches!, userheightfeet: heightinfeet!, position: positions2!)
        performSegue(withIdentifier: "reg_tab_segue", sender: (Any).self)
        
        
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
            registerdone.isEnabled = false
        }
        
        func textFieldDidEndEditing(_ textField: UITextField) {
            //when done editing, updates save button state
            updateDoneButtonState2()
            //navigationItem.title = textField.text
        }
        
        private func updateDoneButtonState2() {
            // Disable the login button if the text field is empty.

            
            let userweighttext = userweight.text ?? ""
            registerdone.isEnabled = !userweighttext.isEmpty
            
            let userhometowntext = userhometown.text ?? ""
            registerdone.isEnabled = !userhometowntext.isEmpty
            
    }
        
    
    
 /*   override func prepare(for segue: UIStoryboardSegue, sender: Any?) {


    }
 */
        
}
