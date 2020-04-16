//
//  BallerProfile.swift
//  Pickup Basketball App
//
//  Created by Ben Svoboda on 4/14/20.
//  Copyright © 2020 Hoop Break. All rights reserved.
//

import UIKit
import os.log


class BallerProfile: UIViewController {
    
    //MARK: Properties
    
    @IBOutlet weak var heightlabel: UILabel!
    @IBOutlet weak var weightlabel: UILabel!
    @IBOutlet weak var prefpositionlabel: UILabel!
    @IBOutlet weak var hometownlabel: UILabel!
    @IBOutlet weak var agelabel: UILabel!
    @IBOutlet weak var gamesplayedlabel: UILabel!
    
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
//        heightlabel.text = userobj!.firstname
        print("hello printing user obj...")
    }

}
