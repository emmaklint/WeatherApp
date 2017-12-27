//
//  Weather.swift
//  WeatherApp
//
//  Created by Emma Klint on 2017-12-11.
//  Copyright © 2017 Emma Klint. All rights reserved.
//

import Foundation
import SwiftSky

class Weather {
    private var _location = "";
    private var _weather = "";
    var _current: DataPoint!
    var _forecast: Forecast!
    
  


    
    var forecast: Forecast! {
        get {
            return _forecast
        }
        set {
            _forecast = newValue
        }
    }
    
    var current: DataPoint! {
        get {
           return _current
        }
        set {
            _current = newValue
        }
    }
    
    func getCurrentTemperature() -> Int {
        return Int((current.temperature?.current?.value)!)
        // For testing
//        return 3.26
    }

    
    func getCurrentIcon() -> String {
        return current.icon!
//        //For testing
//        return "rain"
    }
    
    func getCurrentRain() -> String {
        let rain = (current.precipitation?.probability?.value)!
        return "\(String(describing: rain))"
    }
    
    func getCurrentWind() -> String {
        let wind = (current.wind?.speed?.value)!
        return "\(String(describing: wind))"
    }
    
    func getCurrentSummary() -> String {
        let summary = (current.summary)!
        return "\(String(describing: summary))"
    }

    
    var location: String {
        get {
            return _location
        }
        
        set {
            _location = newValue
        }
    }
    
    var weather: String {
        get  {
            return _weather
        }
        set {
            _weather = newValue
        }
    }
    
    func getCurrentWeather() -> String {
        //return weather.current
        return "Sunny"
    }
    
    func getWeekWeather() -> [String] {
        return ["Rain"]
    }
}
