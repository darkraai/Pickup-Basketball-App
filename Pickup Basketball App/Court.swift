//
//  Court.swift
//  Pickup Basketball App
//
//  Created by Ben Svoboda on 5/1/20.
//  Copyright © 2020 Hoop Break. All rights reserved.
//

import UIKit
import os.log
import MapKit


class Court{

    var coordinates: CLLocationCoordinate2D?
    var parkname: String
    var numcourts: Int
    var Address: String?
    var indoor: Bool
    var membership: Bool
    var courtid: String
    
    

    

    init?(coordinates: CLLocationCoordinate2D, parkname: String, numcourts: Int, Address: String?, indoor: Bool, membership: Bool, courtid:String) {
        // Initialize stored properties.
        self.coordinates = coordinates
        self.parkname = parkname
        self.numcourts = numcourts
        self.Address = Address
        self.indoor = indoor
        self.membership = membership
        self.courtid = courtid

      
    }


}
