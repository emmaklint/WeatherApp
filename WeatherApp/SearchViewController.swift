//
//  SearchViewController.swift
//  WeatherApp
//
//  Created by Emma Klint on 2017-12-07.
//  Copyright © 2017 Emma Klint. All rights reserved.
//

import UIKit
import MapKit

class SearchViewController: UIViewController {
    
  
    @IBOutlet weak var tableView: UITableView!
    
//    var searchResultArray = ["Stockholm", "Göteborg", "Norrköping"]
//
    var delegate: passDataDelegate?
    var city: City!

 
    @IBOutlet weak var searchField: UITextField!
    
    private var searchController:UISearchController = UISearchController()
    
    private let manager = CLLocationManager()
    
    let dataSourece = MapDataSource()
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        searchResultTableView.delegate = self
//        searchResultTableView.dataSource = self
        
        searchController =  UISearchController(searchResultsController:nil )
        searchController.searchBar.sizeToFit()
        searchController.searchBar.searchBarStyle = UISearchBarStyle.minimal
        searchController.searchBar.delegate = dataSourece
        searchController.isActive = true
        tableView.tableHeaderView = searchController.searchBar
        searchController.dimsBackgroundDuringPresentation = false
        definesPresentationContext = true
        
        title = "Location Search"
        
        dataSourece.delegate = self
        
        tableView.dataSource = dataSourece
        tableView.delegate = dataSourece
        
        manager.delegate = dataSourece
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if CLLocationManager.locationServicesEnabled() {
            
            manager.requestWhenInUseAuthorization()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return searchResultArray.count
//
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let searchResult = self.searchResultArray[indexPath.row]
//        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: nil)
//        cell.textLabel?.text = searchResult
//        return cell
//    }
//
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//
//        city.cityname = "Sydney"
//        city.longitude = 151.209296
//        city.latitude = -33.868820
//
//        delegate?.passDataDelegate(obj: city!)
//
//        navigationController?.popViewController(animated: true)
//        dismiss(animated: true, completion: nil)
//    }
//
    
}

extension SearchViewController:MapDataSourceDelegate {
    func setCity(name: String?, long: Double, lat: Double) {
        print("Name" + name!)
        delegate?.passDataDelegate(name: name!, long: long, lat: lat)
        navigationController?.popViewController(animated: true)
        dismiss(animated: true, completion: nil)
    }
    
    func refreshData() {
        self.tableView.reloadData()
    }
}
