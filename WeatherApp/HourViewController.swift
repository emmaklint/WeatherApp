//
//  HourViewController.swift
//  WeatherApp
//
//  Created by Emma Klint on 2017-12-07.
//  Copyright © 2017 Emma Klint. All rights reserved.
//

import UIKit

class HourViewController: UIViewController {

    var weekday : String = ""
    var weatherData : String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = weekday
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

