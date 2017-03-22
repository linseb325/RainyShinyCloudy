//
//  WeatherCell.swift
//  RainyShinyCloudy
//
//  Created by Brennan Linse on 3/20/17.
//  Copyright © 2017 Brennan Linse. All rights reserved.
//

import UIKit

class WeatherCell: UITableViewCell {

    @IBOutlet weak var weatherIcon: UIImageView!
    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var weatherTypeLabel: UILabel!
    @IBOutlet weak var highTempLabel: UILabel!
    @IBOutlet weak var lowTempLabel: UILabel!
    
    
    func configureCell(forecast: Forecast) {
        lowTempLabel.text = "\(forecast.lowTemp)°"
        highTempLabel.text = "\(forecast.highTemp)°"
        weatherTypeLabel.text = forecast.weatherType
        weatherIcon.image = UIImage(named: forecast.weatherType)
        dayLabel.text = forecast.date
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
}
