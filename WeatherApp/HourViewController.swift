//
//  HourViewController.swift
//  WeatherApp
//
//  Created by Emma Klint on 2017-12-07.
//  Copyright © 2017 Emma Klint. All rights reserved.
//

import UIKit
import SwiftSky

class HourViewController: UIViewController {

    var weatherData : Days!
   
    var weekday : String = ""
    var location : String = ""
    var date : String = ""

    var icon : String = "cloudy"
    var temp : Double = 0
    var apperantTemp : Double = 0
    
    var summary : String = "Rain starting in the afternoon, continuing until evening."
    
    var sunrise : String = ""
    var sunset : String = ""
    var rainPercent : Double = 0
    var loTemp : Double = 0
    var hiTemp : Double = 0
    var wind : Double = 0

    
    @IBOutlet weak var dayLabel: UILabel!
    
    @IBOutlet weak var dayIcon: UIImageView!
    @IBOutlet weak var dayTemp: UILabel!
    @IBOutlet weak var dayApperantTemp: UILabel!
    
    @IBOutlet weak var daySummary: UILabel!
    
    @IBOutlet weak var sunTime: UILabel!
    @IBOutlet weak var chanceOfRain: UILabel!
    @IBOutlet weak var hiLoTemp: UILabel!
    @IBOutlet weak var windSpeed: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = location
        getData()
        displayData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getData() {
        //icon = weatherData.icon
    }
    
    func displayData() {
        dayLabel.text = "\(weekday) \(date)"
        dayIcon.image = UIImage(named: icon)
        dayTemp.text = "\(temp) °"
        dayApperantTemp.text = "Feels like \(apperantTemp) °"
        daySummary.text = summary
        sunTime.text = "\(sunrise)/\(sunset)"
        chanceOfRain.text = "\(rainPercent)%"
        hiLoTemp.text = "\(hiTemp)°/\(loTemp)°"
        windSpeed.text = "\(wind) m/s"
    }
    
}

