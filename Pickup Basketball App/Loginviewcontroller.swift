//
//  FirstViewController.swift
//  Pickup Basketball App
//
//  Created by Surya M on 3/22/20.
//  Copyright © 2020 Hoop Break. All rights reserved.
//

import UIKit

class Loginviewcontroller: UIViewController {

    @IBAction func Loginbuttonpressed(_ sender: Any) {
        print("button pressed")
        self.performSegue(withIdentifier: "Logintohomesegue", sender: self)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        print("Loaded sucessfully")
    }


}

