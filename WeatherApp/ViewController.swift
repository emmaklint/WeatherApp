//
//  ViewController.swift
//  WeatherApp
//
//  Created by Emma Klint on 2017-12-06.
//  Copyright © 2017 Emma Klint. All rights reserved.
//

import UIKit

var myIndex = 0
var selectedLocation : String = ""

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var dayTableView: UITableView!
    
    let items = ["Item 1", "Item 2", "Item 3", "Item 4", "Item 5", "Item 6", "Item 7"]
    var weekdayArray = [String]()
    var dateArray = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createDayArrays()
        updateSelectedLocation()
        
        dayTableView.delegate = self
        dayTableView.dataSource = self
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
        return items.count
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
            let HourViewController = segue.destination as! HourViewController
            HourViewController.day = weekdayArray[myIndex]
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
            self.title = "No location selected"
        }
    }
    
    func updateWeather() {
        print("Getting weather for" + selectedLocation)
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

