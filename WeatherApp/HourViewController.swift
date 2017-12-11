//
//  HourViewController.swift
//  WeatherApp
//
//  Created by Emma Klint on 2017-12-07.
//  Copyright © 2017 Emma Klint. All rights reserved.
//

import UIKit

class HourViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var hourTableView: UITableView!
    var hourArray = [String]()

    
    var weekday : String = ""
    var weatherData : String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = weekday
        createHourArray()

        hourTableView.delegate = self
        hourTableView.dataSource = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return hourArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = hourTableView.dequeueReusableCell(withIdentifier: "hourCell")
        cell?.textLabel?.text = hourArray[indexPath.row]
        return cell!
    }
    
    func createHourArray() {
        // Number of hours from API
        let numOfHours = getNumberOfHours(weekday: weekday)
        var index = 0
        while index < numOfHours {
            hourArray.append(createHour(index: index).hourOfDay()!)
            index = index + 1
        }
    }
    
    func createHour(index: Int) -> (Date) {
        let calendar = Calendar.current
        print(calendar)
        let hour = calendar.date(byAdding: .hour, value: index, to: Date())

        return (hour!)
    }
    
    func getNumberOfHours(weekday: String) -> (Int) {
        if (weekday == "Today") {
            print(weekday)
        } else {
            return 24
        }
        return 1
    }
}

extension Date {
    func hourOfDay() -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH"
        return dateFormatter.string(from: self).capitalized
    }
}

