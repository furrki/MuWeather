//
//  DayDetailVC.swift
//  MuWeather
//
//  Created by Admin on 21.03.2019.
//  Copyright © 2019 furrki. All rights reserved.
//

import UIKit

class DayDetailVC: UIViewController {

    var weather: Weather!
    var location: Location!
    
    @IBOutlet weak var weatherIcon: UIImageView!
    @IBOutlet weak var minTempLabel: UILabel!
    @IBOutlet weak var maxTempLabel: UILabel!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    
    @IBOutlet weak var windSpeedLabel: UILabel!
    @IBOutlet weak var windDirectionLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var pressureLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadWeather()
    }
    
    func loadWeather() {
        WeatherService.shared.getIcon(of: weather) { [weak self] (image) in
            DispatchQueue.main.async {
                self?.weatherIcon.image = image
            }
        }
        
        minTempLabel.text = "\(weather.minTemp) °C"
        maxTempLabel.text = "\(weather.maxTemp) °C"
        tempLabel.text = "\(weather.temperature) °C"
        windSpeedLabel.text = "\(weather.windSpeed.limitDecimals()) km/h"
        windDirectionLabel.text = "\(weather.windDirection)"
        humidityLabel.text = "\(weather.humidity)%"
        pressureLabel.text = "\(weather.pressure.limitDecimals()) hPa"
        descriptionLabel.text = weather.description
        locationLabel.text = location.name
        
    }
}
