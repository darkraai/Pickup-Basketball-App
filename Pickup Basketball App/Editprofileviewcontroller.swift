//
//  Editprofileviewcontroller.swift
//  Pickup Basketball App
//
//  Created by Ben Svoboda on 4/19/20.
//  Copyright © 2020 Hoop Break. All rights reserved.
//

import UIKit
import os.log
import FirebaseDatabase
import FirebaseStorage

class Editprofileviewcontroller: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var user24:User?
    
    var metaImageURL:String?
    
    var ref: DatabaseReference!
    
    //textfields initialization
    @IBOutlet weak var editpassword: UITextField!
    @IBOutlet weak var editpasswordre: UITextField!
    @IBOutlet weak var editfirst: UITextField!
    @IBOutlet weak var editlast: UITextField!
    @IBOutlet weak var editweight: UITextField!
    @IBOutlet weak var edithometown: UITextField!
    
    
    @IBOutlet weak var pfpimageview: UIImageView!
    
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
        
        updateDoneButtonState3()

    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ref = Database.database().reference()
        
        editpassword.isSecureTextEntry = true
        editpasswordre.isSecureTextEntry = true
        
        editpassword.text = user24?.password
        editpasswordre.text = user24?.password
        editfirst.text = user24?.firstname
        editlast.text = user24?.lastname
        editweight.text = user24?.userweight
        edithometown.text = user24?.hometown
        pfpimageview.image = user24?.profilepic
        
        //text field delegates
        editpassword.delegate = self
        editpasswordre.delegate = self
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

        self.pfpimageview.layer.cornerRadius = self.pfpimageview.frame.size.width / 2;
        self.pfpimageview.clipsToBounds = true;
        
        
        //initialization for height in feet
        for counter in  0...heightfeet.count-1{
            if(heightfeet[counter] == user24?.userheightfeet){
                heightfpv.selectRow(counter, inComponent:0, animated:true)
            }
        }
                
        heightinfeet = heightfeet[heightfpv.selectedRow(inComponent: 0)]
        

        //initialization for height in inches
        for counter in  0...heightinches.count-1{
            if(heightinches[counter] == user24?.userheightinches){
                heightipv.selectRow(counter, inComponent:0, animated:true)
            }
        }
                
        heightininches = heightinches[heightipv.selectedRow(inComponent: 0)]
        
        
        //initialization for position
               for counter in  0...positions.count-1{
                   if(positions[counter] == user24?.position){
                       positionpv.selectRow(counter, inComponent:0, animated:true)
                   }
               }
                       
               positions2 = positions[positionpv.selectedRow(inComponent: 0)]
        
        

        updateDoneButtonState3()
        
    
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
        saveedits.isEnabled = false
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        //when done editing, updates save button state
        updateDoneButtonState3()
    }

    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        
        if(editpassword.text! != editpasswordre.text){
            let alert = UIAlertController(title: "Error", message: "Your passwords must match", preferredStyle: UIAlertController.Style.alert)
                    alert.addAction(UIAlertAction(title: "Retry", style: UIAlertAction.Style.default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                    return false
                }
        return true
    }
    

    
    //MARK: UIImagePickerControllerDelegate


    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
    
        // Dismiss the picker if the user canceled.
        dismiss(animated: true, completion: nil)
    }
    
    //gets called when user selects a photo. here we will use it to display the photo in imageview
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        // The info dictionary may contain multiple representations of the image. You want to use the original.
        if let selectedImage = info[.editedImage] as? UIImage{
            self.pfpimageview.image = selectedImage
            let imageData = selectedImage.jpegData(compressionQuality: 0.4)!
            let storageRef = Storage.storage().reference(forURL: "gs://pickup-basketball-app.appspot.com")
            let storageProfileRef = storageRef.child("profile").child(user24!.username)
            let metadata = StorageMetadata()
            metadata.contentType = "image/jpg"
            
            storageProfileRef.putData(imageData, metadata: metadata, completion:
                {(storageMetaData, error) in
                    
                storageProfileRef.downloadURL(completion: {(url, error) in
                    if let metaImageURL = url?.absoluteString{
                        self.metaImageURL = metaImageURL
                    }
                })
            })
        }else {fatalError("Expected a dictonary containing an image, but was provided the following: \(info)")}
        

        self.pfpimageview.layer.cornerRadius = self.pfpimageview.frame.size.width / 2;
        self.pfpimageview.clipsToBounds = true;
        
        // Dismiss the picker.
        dismiss(animated: true, completion: nil)
    }
    

    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        pfpimageview.layer.cornerRadius = pfpimageview.frame.size.width / 2;
        pfpimageview.clipsToBounds = true;
        let destinationViewController = segue.destination as! BallerProfile
        
        if (self.metaImageURL == nil){
            destinationViewController.user24 = User(firstname: editfirst.text!, lastname: editlast.text!, username: user24!.username, password: editpassword.text!, userweight: editweight.text!, hometown: edithometown.text!, userheightinches: heightininches!, userheightfeet: heightinfeet!, position: positions2!, profilepic: pfpimageview.image,pfplink: self.user24?.pfplink)
            
            self.ref.child("Users").child(self.user24!.username).setValue(["firstname":editfirst.text!, "lastname":editlast.text!,"fullname": (editfirst.text! + " " + editlast.text!).lowercased(), "password":editpassword.text!,"weight":editweight.text!, "hometown":edithometown.text!,"heightfeet":heightinfeet!,"heightinches":heightininches!,"position":positions2!, "username":self.user24?.username, "pfp":self.user24?.pfplink])
        } else{
            destinationViewController.user24 = User(firstname: editfirst.text!, lastname: editlast.text!, username: user24!.username, password: editpassword.text!, userweight: editweight.text!, hometown: edithometown.text!, userheightinches: heightininches!, userheightfeet: heightinfeet!, position: positions2!, profilepic: pfpimageview.image,pfplink: self.metaImageURL)
            
            self.ref.child("Users").child(self.user24!.username).setValue(["firstname":editfirst.text!, "lastname":editlast.text!, "fullname": (editfirst.text! + " " + editlast.text!).lowercased(), "password":editpassword.text!,"weight":editweight.text!, "hometown":edithometown.text!,"heightfeet":heightinfeet!,"heightinches":heightininches!,"position":positions2!, "username":self.user24?.username, "pfp":self.metaImageURL])
        }
    }
    
        
    
    //MARK: Actions
    
    
    @IBAction func selectImageFromPhotoLibrary(_ sender: UITapGestureRecognizer) {
        //closes keyboards for text fields
        editpasswordre.resignFirstResponder()
        editpassword.resignFirstResponder()
        editfirst.resignFirstResponder()
        editlast.resignFirstResponder()
        edithometown.resignFirstResponder()
        editweight.resignFirstResponder()
        

        // UIImagePickerController is a view controller that lets a user pick media from their photo library.
        let imagePickerController = UIImagePickerController()

        imagePickerController.allowsEditing = true
        
        // Only allow photos to be picked, not taken.
        imagePickerController.sourceType = .photoLibrary

        // Make sure ViewController is notified when the user picks an image.
        imagePickerController.delegate = self

        present(imagePickerController, animated: true, completion: nil)
        
        
    }
    
    @IBAction func selectImageFromPhotoLibrary2(_ sender: UITapGestureRecognizer) {
        //closes keyboards for text fields
        editpasswordre.resignFirstResponder()
        editpassword.resignFirstResponder()
        editfirst.resignFirstResponder()
        editlast.resignFirstResponder()
        edithometown.resignFirstResponder()
        editweight.resignFirstResponder()
        

        // UIImagePickerController is a view controller that lets a user pick media from their photo library.
        let imagePickerController = UIImagePickerController()

        imagePickerController.allowsEditing = true
        
        // Only allow photos to be picked, not taken.
        imagePickerController.sourceType = .photoLibrary

        // Make sure ViewController is notified when the user picks an image.
        imagePickerController.delegate = self

        present(imagePickerController, animated: true, completion: nil)
        
    }
    
    private func updateDoneButtonState3() {
        // Disable the login button if the text field is empty.
        saveedits.isEnabled = false
    
        let userfirsttext = editfirst.text ?? ""
            
        let userlasttext = editlast.text ?? ""
            
        let usernametext = editpasswordre.text ?? ""
            
        let userpasswordtext = editpassword.text ?? ""
            
        let userweighttext = editweight.text ?? ""
        
        let userhometowntext = edithometown.text ?? ""
            
        if((!userfirsttext.isEmpty)&&(!userlasttext.isEmpty)&&(!usernametext.isEmpty)&&(!userpasswordtext.isEmpty)&&(!userhometowntext.isEmpty) && (!userweighttext.isEmpty)&&(heightinfeet != nil)&&(heightinfeet != " ")&&(heightininches != nil)&&(heightininches != " ")&&(positions2 != nil)&&(positions2 != " ")&&(CharacterSet(charactersIn: "1234567890").isSuperset(of: CharacterSet(charactersIn: userweighttext)))){
                saveedits.isEnabled = true

            }
    }
        
}





