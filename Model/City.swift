//
//  City.swift
//  WeatherApp
//
//  Created by Emma Klint on 2017-12-11.
//  Copyright © 2017 Emma Klint. All rights reserved.
//

import Foundation

class City {
    private var _cityname = "";
    private var _longitude: Double = 0
    private var _latitude: Double = 0
    private var _recent = [String]()
    
    var cityname: String {
        get {
            return _cityname
        }
        
        set {
            _cityname = newValue
        }
    }
    
    var longitude: Double {
        get {
            return _longitude
        }
        
        set {
            _longitude = newValue
        }
    }
    
    var latitude: Double {
        get {
            return _latitude
        }
        
        set {
            _latitude = newValue
        }
    }
    
}
