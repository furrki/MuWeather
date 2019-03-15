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
    
    func getWeatherData(woeid: String) {
        AF.request(getUrlFor(woeid: woeid)).responseJSON(completionHandler: { (res) in
            self.decode(from: res.data!)
        })
    }
    
    func decode(from data: Data) {
        do {
            let json = try JSON(data: data)
            if let weathers = json["consolidated_weather"].array {
                for weather in weathers {
                    if let weatherStateName = weather["weather_state_name"].string {
                        print(weatherStateName)
                    }
                }
            }
        } catch {
            fatalError("Error getting data from Network")
        }
    }
}
