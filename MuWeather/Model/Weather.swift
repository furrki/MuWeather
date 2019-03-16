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
    var humidity: Int
    var pressure: Double
    var date: Date
    var iconString: String
    var locationDescription = ""
    
    var windDirection: String
    var longDescription: String {
        return "\(description) \(temperature) \(pressure) \(humidity) \(date) \(windDirection) \(windSpeed) "
    }
    
    var dateString: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy - HH:mm"
        return dateFormatter.string(from: date)
    }
    
    init(description: String, windSpeed: Double, windDirection: String, temperature: Int, humidity: Int, pressure: Double, date: Date, iconString: String, city: String? = nil) {
        self.description = description
        self.windSpeed = windSpeed
        self.windDirection = windDirection
        self.temperature = temperature
        self.humidity = humidity
        self.pressure = pressure
        self.date = date
        self.iconString = iconString
        if city != "" {
            self.locationDescription = "\(city ?? "")"
        }
    }

}
