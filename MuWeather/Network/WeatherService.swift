//
//  WeatherService.swift
//  MuWeather
//
//  Created by Admin on 15.03.2019.
//  Copyright © 2019 furrki. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class WeatherService {
    static var shared = WeatherService()
    
    func getUrlFor(woeid: String) -> String {
        return "\(apiURL)/\(woeid)"
    }
    
    func getUrlFor(woeid: String, date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy/M/d"
        let dateUrlPart = dateFormatter.string(from: date)
        return "\(apiURL)/\(woeid)/\(dateUrlPart)"
    }
    
    func isValidWoeid(woeid: String, finish: @escaping ((_ isValid: Bool) -> Void)) {
        AF.request(getUrlFor(woeid: woeid)).responseJSON(completionHandler: { (res) in
            do {
                let json = try JSON(data: res.data!)
                if let result = json["detail"].string {
                    if result == "Not found." {
                        finish(false)
                        return
                    }
                }
                finish(true)
            } catch {
                finish(false)
            }
        })
    }
    
    func getWeatherData(woeid: String) {
        AF.request(getUrlFor(woeid: woeid)).responseJSON(completionHandler: { (res) in
            self.decode(from: res.data!)
        })
    }
    
    func decode(from data: Data) -> Weather? {
        do {
            let json = try JSON(data: data)
            if let weathers = json["consolidated_weather"].array {
                for weather in weathers {
                    if let weatherStateName = weather["weather_state_name"].string,
                        let iconString = weather["weather_state_abbr"].string,
                        let windDirection = weather["wind_direction_compass"].string,
                        let temperature = weather["the_temp"].double,
                        let pressure = weather["air_pressure"].double,
                        let humidity = weather["humidity"].int,
                        let windSpeed = weather["wind_speed"].double {
                        
                        return Weather(description: weatherStateName, windSpeed: windSpeed, windDirection: windDirection, temperature: Int(temperature), humidity: humidity, pressure: pressure, date: Date(), iconString: iconString)
                    }
                }
            }
        } catch {
            fatalError("Error getting data from Network")
        }
        return nil
    }
}
