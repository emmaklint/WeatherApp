//
//  Protocol.swift
//  WeatherApp
//
//  Created by Emma Klint on 2017-12-11.
//  Copyright © 2017 Emma Klint. All rights reserved.
//

import Foundation

protocol passDataDelegate {
    func passDataDelegate(name: String, long: Double, lat: Double)
}
