//
//  CurrentWeather.swift
//  RainyShinyCloudy
//
//  Created by Brennan Linse on 1/20/17.
//  Copyright © 2017 Brennan Linse. All rights reserved.
//

import Foundation
import Alamofire

class CurrentWeather {
    
    var _cityName: String!
    var _date: String!
    var _weatherType: String!
    var _currentTemp: Double!
    
    
    var cityName: String {
        if _cityName == nil {
            _cityName = ""
        }
        return _cityName
    }
    
    var date: String {
        if _date == nil {
            _date = ""
        }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .long
        dateFormatter.timeStyle = .none
        let currentDate = dateFormatter.string(from: Date())
        self._date = "Today: \(currentDate)"
        
        return _date
    }
    
    var weatherType: String {
        if _weatherType == nil {
            _weatherType = ""
        }
        return _weatherType
    }
    
    var currentTemp: Double {
        if _currentTemp == nil {
            _currentTemp = 0.0
        }
        return _currentTemp
    }
    
    
    public func downloadWeatherDetails(completed: @escaping DownloadComplete) {
        // Download current weather data
        
        let currentWeatherURL = URL(string: currentWeatherURLforCoordinates(latitude: Location.sharedInstance.latitude, longitude: Location.sharedInstance.longitude))
        Alamofire.request(currentWeatherURL!).responseJSON { response in
            let result = response.result
            
            if let dict = result.value as? Dictionary<String, Any> {
                // Get the city name
                if let name = dict["name"] as? String {
                    self._cityName = name.capitalized
                    // print("Retrieved city name: \(self._cityName!)")
                }
                // Get the weather type
                if let weather = dict["weather"] as? [Dictionary<String, Any>] {
                    if let main = weather[0]["main"] as? String {
                        self._weatherType = main.capitalized
                        // print("Retrieved weather type: \(self._weatherType!)")
                    }
                }
                // Get the current temperature
                if let main = dict["main"] as? Dictionary<String, Any> {
                    if let currTemp = main["temp"] as? Double {
                        let tempInFahrenheit = kelvinToFahrenheit(kelvinTemp: currTemp)
                        let roundedTempInFahrenheit = round(10 * tempInFahrenheit) / 10
                        self._currentTemp = roundedTempInFahrenheit
                        // print("Retrieved current temp: \(self._currentTemp!)")
                    }
                }
            }
            completed()     // Found error on 3/18/17: I had this line after the next curly brace. BUT why didn't it work before?
        }
    }
    
    
    
    
}
