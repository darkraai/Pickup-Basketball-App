//
//  User.swift
//  Pickup Basketball App
//
//  Created by Ben Svoboda on 4/3/20.
//  Copyright © 2020 Hoop Break. All rights reserved.
//

import UIKit
import os.log


class User{
    
    //MARK: Properties
    //properties of a user. In the future optional properties such as photo will be added
    var firstname: String
    var lastname: String
    var email: String
    var username: String
    var password: String
    
    
    //creates property key
    struct PropertyKey{
        static let firstname = "first name"
        static let lastname = "last name"
        static let email = "email"
        static let username = "username"
        static let password = "password"
    }
    
    //MARK: Initialization
    //Recall that an initializer is a method that prepares an instance of a class for use, which involves setting an initial value for each property and performing any other setup or initialization.
    init?(firstname: String, lastname: String, email: String, username: String, password: String) {
        

    


        // Initialize stored properties.
        self.firstname = firstname
        self.lastname = lastname
        self.email = email
        self.username = username
        self.password = password



    }
    
}
