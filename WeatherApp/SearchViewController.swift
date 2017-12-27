//
//  SearchViewController.swift
//  WeatherApp
//
//  Created by Emma Klint on 2017-12-07.
//  Copyright © 2017 Emma Klint. All rights reserved.
//

import UIKit
import MapKit

class SearchViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
  
    
    @IBOutlet weak var searchResultTableView: UITableView!
    var searchResultArray = ["Stockholm", "Göteborg", "Norrköping"]
    
    var delegate: passDataDelegate?
    var city: City!

 
    @IBOutlet weak var searchField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchResultTableView.delegate = self
        searchResultTableView.dataSource = self
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResultArray.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let searchResult = self.searchResultArray[indexPath.row]
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: nil)
        cell.textLabel?.text = searchResult
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        city.cityname = "Sydney"
        city.longitude = 151.209296
        city.latitude = -33.868820
        
        delegate?.passDataDelegate(obj: city!)

        navigationController?.popViewController(animated: true)
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func test(_ sender: UIButton) {
        let query = searchField.text
    
        print(query!)
    

        searchLocation()
    }
    
    func searchLocation() {
        
    }
}
