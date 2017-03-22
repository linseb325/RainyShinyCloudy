//
//  Forecast.swift
//  RainyShinyCloudy
//
//  Created by Brennan Linse on 3/18/17.
//  Copyright © 2017 Brennan Linse. All rights reserved.
//

import UIKit
import Alamofire

class Forecast {
    
    var _date: String!
    var _weatherType: String!
    var _highTemp: Double!
    var _lowTemp: Double!
    
    var date: String {
        if _date == nil {
            _date = ""
        }
        return _date
    }
    
    var weatherType: String {
        if _weatherType == nil {
            _weatherType = ""
        }
        return _weatherType
    }
    
    var highTemp: Double {
        if _highTemp == nil {
            _highTemp = 0.0
        }
        return _highTemp
    }
    
    var lowTemp: Double {
        if _lowTemp == nil {
            _lowTemp = 0.0
        }
        return _lowTemp
    }
    
    // Initializer
    init(weatherDict: Dictionary<String, Any>) {
        // Set instance variables based on the data in the parameter dictionary
        
        // Parse high and low temperatures
        if let temp = weatherDict["temp"] as? Dictionary<String, Any> {
            if let max = temp["max"] as? Double {
                self._highTemp = round(kelvinToFahrenheit(kelvinTemp: max) * 10) / 10
            }
            if let min = temp["min"] as? Double {
                self._lowTemp = round(kelvinToFahrenheit(kelvinTemp: min) * 10) / 10
            }
        }
        // Parse weather type
        if let weather = weatherDict["weather"] as? [Dictionary<String, Any>] {
            if let main = weather[0]["main"] as? String {
                self._weatherType = main.capitalized
            }
        }
        // Parse date
        if let date = weatherDict["dt"] as? Double {
            let unixConvertedDate = Date(timeIntervalSince1970: date)
            let formatter = DateFormatter()
            formatter.dateStyle = .full
            formatter.dateFormat = "EEEE"
            formatter.timeStyle = .none
            self._date = unixConvertedDate.dayOfTheWeek()
        }
        
    }
}



extension Date {
    func dayOfTheWeek() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE"
        return formatter.string(from: self)
    }
}



