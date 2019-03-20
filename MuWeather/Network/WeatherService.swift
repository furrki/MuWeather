//
//  WeatherService.swift
//  MuWeather
//
//  Created by Admin on 15.03.2019.
//  Copyright © 2019 furrki. All rights reserved.
//

import UIKit
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
    
    func getIconUrl(for iconString: String) -> String {
        return "https://www.metaweather.com/static/img/weather/png/64/\(iconString).png"
    }
    
    func isValidWoeid(woeid: String, finish: @escaping (_ isValid: Bool, _ cityName: String?) -> Void ) {
        AF.request(getUrlFor(woeid: woeid)).responseJSON(completionHandler: { (res) in
            do {
                let json = try JSON(data: res.data!)
                if let result = json["detail"].string {
                    if result == "Not found." {
                        finish(false, nil)
                        return
                    }
                }
                if let name = json["title"].string {
                    finish(true, name)
                    return
                }
            } catch {
                finish(false, nil)
            }
        })
    }
    
    func getWeatherData(of woeid: String, got: @escaping (_ weathers: [Weather]) -> Void ) {
        AF.request(getUrlFor(woeid: woeid)).responseJSON(completionHandler: { (res) in
            let weathers = self.getConsolidatedWeathers(from: res.data!)
            got(weathers)
        })
    }
    
    func getConsolidatedWeathers(from data: Data) -> [Weather] {
        do {
            var weathers = [Weather]()
            let json = try JSON(data: data)
            if let weatherDatas = json["consolidated_weather"].array {
                for weather in weatherDatas {
                    if let decodedWeather = decode(weather: weather) {
                        weathers.insert(decodedWeather, at: 0)
                    }
                }
            }
            return weathers
        } catch {
            fatalError("Error getting data from Network")
        }
        return []
    }
    
    func decode(weather: JSON) -> Weather? {
        if let weatherStateName = weather["weather_state_name"].string,
            let iconString = weather["weather_state_abbr"].string,
            let windDirection = weather["wind_direction_compass"].string,
            let date = weather["applicable_date"].string,
            let temperature = weather["the_temp"].double,
            let pressure = weather["air_pressure"].double,
            let humidity = weather["humidity"].int,
            let minTemp = weather["min_temp"].int,
            let maxTemp = weather["max_temp"].int,
            let windSpeed = weather["wind_speed"].double {
            
            return Weather(description: weatherStateName, windSpeed: windSpeed, windDirection: windDirection, temperature: Int(temperature), humidity: humidity, pressure: pressure, dateString: date, iconString: iconString, minTemp: minTemp, maxTemp: maxTemp)
        }
        return nil
    }
    
    func getIcon(of weather: Weather, got: @escaping (_ icon: UIImage) -> Void) {
        AF.request(getIconUrl(for: weather.iconString), method: .get)
            .validate()
            .responseData(completionHandler: { (responseData) in
                got(UIImage(data: responseData.data!)!)
            })
    }
}
