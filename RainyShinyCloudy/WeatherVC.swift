//
//  WeatherVC.swift
//  RainyShinyCloudy
//
//  Created by Brennan Linse on 1/19/17.
//  Copyright © 2017 Brennan Linse. All rights reserved.
//

import UIKit
import Alamofire
import CoreLocation

class WeatherVC: UIViewController, UITableViewDelegate, UITableViewDataSource, CLLocationManagerDelegate {
    
    
    @IBOutlet weak var todaysDateLabel: UILabel!
    @IBOutlet weak var currentTempLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var currentWeatherImage: UIImageView!
    @IBOutlet weak var currentWeatherLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    var currentWeather = CurrentWeather()
    var forecasts = [Forecast]()
    
    let locationManager = CLLocationManager()
    var currentLocation: CLLocation!
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.locationAuthStatus()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startMonitoringSignificantLocationChanges()
        
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    
    // We download the forecast data in the ViewController because it is where we'll set up the table view.
    func downloadForecastData(completed: @escaping DownloadComplete) {
        let forecastURL = URL(string: forecastURLforCoordinates(latitude: Location.sharedInstance.latitude, longitude: Location.sharedInstance.longitude, numDays: 10))
        Alamofire.request(forecastURL!).responseJSON { response in
            let result = response.result
            
            // Reminder: alternative notation for dictionaries in the line below...
            if let dict = result.value as? [String : Any] {
                if let list = dict["list"] as? [Dictionary<String, Any>] {
                    for aDict in list {
                        let forecast = Forecast(weatherDict: aDict)
                        self.forecasts.append(forecast)
                    }
                    self.forecasts.remove(at: 0)    // Because we don't want today's forecast to show up in the table view
                    self.tableView.reloadData()
                }
            }
            completed()
        }
    }
    
    // Table view functions:
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return forecasts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "WeatherCell", for: indexPath) as? WeatherCell {
            let forecast = forecasts[indexPath.row]
            cell.configureCell(forecast: forecast)
            return cell
        } else {
            return WeatherCell()
        }
    }
    
    
    func updateMainUI() {
            todaysDateLabel.text = currentWeather.date
            currentTempLabel.text = "\(currentWeather.currentTemp)°"
            locationLabel.text = currentWeather.cityName
            currentWeatherImage.image = UIImage(named: currentWeather.weatherType)
            currentWeatherLabel.text = currentWeather.weatherType
            // print("Inside updateMainUI function; the current weather label should read: \(currentWeather.weatherType)")
    }
    
    
    func locationAuthStatus() {
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse {
            currentLocation = locationManager.location
            Location.sharedInstance.latitude = currentLocation.coordinate.latitude
            Location.sharedInstance.longitude = currentLocation.coordinate.longitude
            currentWeather.downloadWeatherDetails {
                self.downloadForecastData {
                    self.updateMainUI()
                }
            }
            print("Lat & Long:", Location.sharedInstance.latitude, Location.sharedInstance.longitude)
        } else {
            locationManager.requestWhenInUseAuthorization()
            self.locationAuthStatus()
        }
    }
    
    
    
    
    
    
    
    
    
    
}

