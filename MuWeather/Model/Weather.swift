//
//  Weather.swift
//  MuWeather
//
//  Created by Admin on 16.03.2019.
//  Copyright © 2019 furrki. All rights reserved.
//

import Foundation

class Weather {
    var description: String
    var windSpeed: Double
    var temperature: Int
    var minTemp: Int
    var maxTemp: Int
    var humidity: Int
    var pressure: Double
    var iconString: String
    var locationDescription = ""
    
    var windDirection: String
    var longDescription: String {
        return "\(description) \(temperature) \(pressure) \(humidity) \(dateString) \(windDirection) \(windSpeed) "
    }
    
    var dateString: String
    
    init(description: String, windSpeed: Double, windDirection: String, temperature: Int, humidity: Int, pressure: Double, dateString: String, iconString: String, minTemp: Int, maxTemp: Int) {
        self.description = description
        self.windSpeed = windSpeed
        self.windDirection = windDirection
        self.temperature = temperature
        self.humidity = humidity
        self.pressure = pressure
        self.dateString = dateString
        self.iconString = iconString
        self.minTemp = minTemp
        self.maxTemp = maxTemp
    }

}
