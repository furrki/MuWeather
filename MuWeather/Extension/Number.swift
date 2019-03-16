//
//  Number.swift
//  MuWeather
//
//  Created by Admin on 16.03.2019.
//  Copyright © 2019 furrki. All rights reserved.
//

import Foundation
extension Double {
    func limitDecimals() -> Double {
        return Double((1000 * self).rounded()/1000)
    }
}
