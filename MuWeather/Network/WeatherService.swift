//
//  WeatherService.swift
//  MuWeather
//
//  Created by Admin on 15.03.2019.
//  Copyright © 2019 furrki. All rights reserved.
//

import Foundation
import Alamofire

class WeatherService {
    static var shared = WeatherService()
    
    func getUrlFor(woeid: String) -> String {
        return "\(apiURL)/\(woeid)"
    }
    
    func getUrlFor(woeid: String, date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "d/MM/yyyy"
        let dateUrlPart = dateFormatter.string(from: date)
        return "\(apiURL)/\(woeid)/\(dateUrlPart)"
    }
}
