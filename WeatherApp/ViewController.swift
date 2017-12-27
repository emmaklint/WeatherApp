//
//  ViewController.swift
//  WeatherApp
//
//  Created by Emma Klint on 2017-12-06.
//  Copyright © 2017 Emma Klint. All rights reserved.
//

import UIKit
import SwiftSky

var myIndex = 0
var latitude = 59.3333
var longitude = 18.0500

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, passDataDelegate  {

    @IBOutlet weak var dayTableView: UITableView!
    @IBOutlet weak var currentIcon: UIImageView!
    @IBOutlet weak var currentTemp: UILabel!
    
    var weekdayArray = [String]()
    var dateArray = [String]()
    var tempArray : [Int] = [3, 5, 10, 14, 7, 9, 5]
    var dayArray = [Days]()
    var weather: Weather!
    var selectedCity: City!
    var currentCity: City!
    var recent = [City]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        SwiftSky.secret = "18f89b0b82ef552ec09ecff33cb281ff"
        
        SwiftSky.hourAmount = .hundredSixtyEight
        SwiftSky.language = .english
        SwiftSky.locale = .autoupdatingCurrent
        SwiftSky.units.temperature = .celsius
        SwiftSky.units.distance = .kilometer
        SwiftSky.units.speed = .meterPerSecond
        SwiftSky.units.pressure = .millibar
        SwiftSky.units.precipitation = .millimeter
        SwiftSky.units.accumulation = .centimeter

        createDayArrays()
        createGradientBackground()

        
        self.selectedCity = City()
        
        dayTableView.delegate = self
        dayTableView.dataSource = self
    }
    
    func createGradientBackground() {
        let topColor = UIColor(red: (56/255.0), green: (138/225.0), blue: (234/255.0), alpha: 1)
        let bottomColor = UIColor(red: (105/255.0), green: (190/225.0), blue: (246/255.0), alpha: 1)
        
        
        let gradientColors: [CGColor] = [topColor.cgColor, bottomColor.cgColor]
        let gradientLocation: [NSNumber] = [0.0, 1.0]
        
        let gradientLayer : CAGradientLayer = CAGradientLayer()
        gradientLayer.colors = gradientColors
        gradientLayer.locations = gradientLocation
        
        gradientLayer.frame = self.view.bounds
        self.view.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        if currentCity == nil {
            // Display current location
            currentCity = City()
            currentCity.cityname = "New York"
            currentCity.longitude = -74.005973
            currentCity.latitude = 40.712775
            
            selectedCity = currentCity
        }
            
        // New city has been choosen
        else {
            currentCity = selectedCity
        }
        
        updateselectedCity()
        updateWeather()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //Gesture swipe down to updateweather
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return weekdayArray.count
    }
    
    // Set cell content
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = dayTableView.dequeueReusableCell(withIdentifier: "dayCell") as! CustomTableViewCell
        cell.weekdayLabel.text = weekdayArray[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    // Click on cell
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        myIndex = indexPath.row
//        performSegue(withIdentifier: "hourSegue", sender: self)
//    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "hourSegue" {
            //weather.getHourlyData(timestamp)
            let HourViewController = segue.destination as! HourViewController
            HourViewController.weekday = weekdayArray[myIndex]
            HourViewController.date = dateArray[myIndex]
            HourViewController.location = selectedCity.cityname
            //Send day object
//            HourViewController.weatherData = dayArray[myIndex]
        } else if segue.identifier == "searchSegue" {
            let SearchViewController = segue.destination as! SearchViewController
            SearchViewController.delegate = self
            SearchViewController.city = selectedCity
        }
    }
    
    func createDayArrays() {
        var index = 0
        
        while index < 7 {
            let result = createDay(index: index)
            if index == 0 {
                weekdayArray.append("Today")
            }
//            else if index == 1 {
//                weekdayArray.append("Tomorrow")
//            }
            else {
                weekdayArray.append(result.weekday)
            }
            dateArray.append(result.date.dateFormatted())
            index = index + 1;
        }
    }
    
    func createDay(index: Int) -> (weekday: String, date: Date) {
        let calendar = Calendar.current
        let date = calendar.date(byAdding: .day, value: index, to: Date())
        let weekday = date?.dayOfWeek()
        
        return (weekday!, date!)
    }
    
    func updateselectedCity() {
        if selectedCity != nil {
            self.title = selectedCity.cityname
        } else {
//             Set selected location to most recent location
            self.title = "No location selected"
        }
    }
    
    func updateWeather() {
     
        print("Getting weather for " + selectedCity.cityname)
        
//        SwiftSky.get([.current, .minutes, .hours, .days, .alerts],
//                     at: Location(latitude: selectedCity.latitude, longitude: selectedCity.longitude)
//        ) { result in
//            switch result {
//            case .success(let forecast):
//                self.weather = Weather()
//                self.weather.current = forecast.current
//                self.setCurrentWeather()
//
//            case .failure(let error):
//                print(error)
//            }
//        }
        
        setCurrentWeather()

    }
    
    func setCurrentWeather() {
//        let currentTemperature = weather.getCurrentTemperature()
//        let currentIcon = (current.icon)
        
        let currentTemperatureVal = 25

        currentTemp.text = "\(currentTemperatureVal)°"
//        iconLabel.text = currentIcon
    }
    
    func setDailyWeather() {
        
    }

    
    func passDataDelegate(obj: City) {
        self.selectedCity = obj
    }
    
    
    
}


extension Date {
    func dayOfWeek() -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        return dateFormatter.string(from: self).capitalized
    }
    
    func dateFormatted() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "d MMM"
        return dateFormatter.string(from: self).capitalized
    }
}




