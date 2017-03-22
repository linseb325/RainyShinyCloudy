//
//  Location.swift
//  RainyShinyCloudy
//
//  Created by Brennan Linse on 3/20/17.
//  Copyright © 2017 Brennan Linse. All rights reserved.
//

import CoreLocation

class Location {
    static var sharedInstance = Location()
    private init() { /* Don't need this block */ }
    
    var latitude: Double!
    var longitude: Double!
}
