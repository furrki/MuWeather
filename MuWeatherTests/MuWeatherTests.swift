//
//  MuWeatherTests.swift
//  MuWeatherTests
//
//  Created by Admin on 15.03.2019.
//  Copyright © 2019 furrki. All rights reserved.
//

import XCTest
@testable import MuWeather

class MuWeatherTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testLimitDecimals() {
        XCTAssertEqual((0.54321).limitDecimals(), 0.5)
        XCTAssertEqual((10.54321).limitDecimals(), 10.5)
        XCTAssertEqual((10).limitDecimals(), 10.0)
        XCTAssertEqual((0.2).limitDecimals(), 0.2)
    }
    
    func testWeatherModel() {
        let weather = Weather(description: "rain", windSpeed: 2.0, windDirection: "NE", temperature: 10, humidity: 5, pressure: 100, dateString: "Now", iconString: "na", minTemp: 5, maxTemp: 15)
        XCTAssert(weather.description == "rain")
        XCTAssert(weather.windSpeed == 2.0)
        XCTAssert(weather.windDirection == "NE")
        XCTAssert(weather.temperature == 10)
        XCTAssert(weather.humidity == 5)
        XCTAssert(weather.minTemp == 5)
        XCTAssert(weather.maxTemp == 15)
        XCTAssert(weather.dateString == "Now")
        XCTAssert(weather.iconString == "na")
    }

}
