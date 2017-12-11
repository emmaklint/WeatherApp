//
//  ViewController.swift
//  WeatherApp
//
//  Created by Emma Klint on 2017-12-06.
//  Copyright © 2017 Emma Klint. All rights reserved.
//

import UIKit
import MapKit
import SwiftSky

var myIndex = 0
var selectedLocation : String = ""
var latitude = 59.3333
var longitude = 18.0500



class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    let locationManager = CLLocationManager()


    @IBOutlet weak var dayTableView: UITableView!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var iconLabel: UILabel!
    
    var weekdayArray = [String]()
    var dateArray = [String]()
    
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
        updateSelectedLocation()
        
        dayTableView.delegate = self
        dayTableView.dataSource = self
        
        locationManager.delegate = self as CLLocationManagerDelegate
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
  
    }
    
    override func viewDidAppear(_ animated: Bool) {
        updateSelectedLocation()
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
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = dayTableView.dequeueReusableCell(withIdentifier: "dayCell")
        cell?.textLabel?.text = weekdayArray[indexPath.row]
        cell?.detailTextLabel?.text = dateArray[indexPath.row]
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        myIndex = indexPath.row
        performSegue(withIdentifier: "hourSegue", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "hourSegue" else {return}
            //API CALL TO GET DAY DATA
            let HourViewController = segue.destination as! HourViewController
            HourViewController.weekday = weekdayArray[myIndex]
            HourViewController.weatherData = dateArray[myIndex]

    }
    
    func createDayArrays() {
        var index = 0
        
        while index < 7 {
            let result = createDay(index: index)
            if index == 0 {
                weekdayArray.append("Today")
            } else if index == 1 {
                weekdayArray.append("Tomorrow")
            } else {
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
    
    func updateSelectedLocation() {
        if selectedLocation != "" {
            self.title = selectedLocation
        } else {
            // Set selected location to most recent location
            self.title = "No location selected"
        }
    }
    
    func updateWeather() {
     
        // IF NOT SAME DATA
        print("Getting weather for" + selectedLocation)
        
//        SwiftSky.get([.current, .minutes, .hours, .days, .alerts],
//                     at: Location(latitude: latitude, longitude: longitude)
//        ) { result in
//            switch result {
//            case .success(let forecast):
//                self.setCurrentWeather(current: forecast.current!)
//            case .failure(let error):
//                print(error)
//            }
//        }
        
       
    }
    
    func setCurrentWeather(current: DataPoint) {
        let currentTemperature = (current.temperature!.current?.value)
        let currentIcon = (current.icon)
        
        tempLabel.text = "\(currentTemperature!)"
        iconLabel.text = currentIcon
    }
    
    func getDailyWeather(temp: Double, icon: String) {
        
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
        dateFormatter.dateFormat = "d MMMM"
        return dateFormatter.string(from: self).capitalized
    }
}

extension ViewController : CLLocationManagerDelegate {
    private func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse {
            locationManager.requestLocation()
        }
    }
    
    private func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if locations.first != nil {
            print("location:: (location)")
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("error:: (error)")
    }
}
