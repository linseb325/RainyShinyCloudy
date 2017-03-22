//
//  Constants.swift
//  RainyShinyCloudy
//
//  Created by Brennan Linse on 1/20/17.
//  Copyright © 2017 Brennan Linse. All rights reserved.
//

import Foundation


let BASE_URL = "http://api.openweathermap.org/data/2.5/weather?"
let BASE_FORECAST_URL = "http://api.openweathermap.org/data/2.5/forecast/daily?"
let LATITUDE = "lat="
let LONGITUDE = "&lon="
let APP_ID = "&appid="
let API_KEY = "ee9809d517924ed3e5efb79415153c65"

let CURRENT_WEATHER_URL = "http://api.openweathermap.org/data/2.5/weather?let=\(Location.sharedInstance.latitude)&lon=\(Location.sharedInstance.longitude)&appid=\(API_KEY)"
let FORECAST_URL = "http://api.openweathermap.org/data/2.5/forecast/daily?lat=\(Location.sharedInstance.latitude)&lon=\(Location.sharedInstance.longitude)&cnt=10&mode=json&appid=\(API_KEY)"

typealias DownloadComplete = () -> ()


// Mequon coordinates: 43.2, -88.0

func currentWeatherURLforCoordinates(latitude: Double, longitude: Double) -> String {
    return "\(BASE_URL)\(LATITUDE)\(latitude)\(LONGITUDE)\(longitude)\(APP_ID)\(API_KEY)"
}

func forecastURLforCoordinates(latitude: Double, longitude: Double, numDays: Int) -> String {
    if (0 < numDays && numDays < 17) {
        return "\(BASE_FORECAST_URL)\(LATITUDE)\(latitude)\(LONGITUDE)\(longitude)&cnt=\(numDays)\(APP_ID)\(API_KEY)"
    } else {
        print("Invalid number of days for forecast data. Returning the empty string")
        return ""
    }
}

func kelvinToFahrenheit(kelvinTemp: Double) -> Double {
    return kelvinTemp * (9/5) - 459.67
}







