//
//  MapDataSource.swift
//  WeatherApp
//
//  Created by Emma Klint on 2017-12-28.
//  Copyright © 2017 Emma Klint. All rights reserved.
//

import UIKit
import MapKit

protocol MapDataSourceDelegate: class{
    func refreshData()
    func setCity(name: String?, long: Double, lat: Double)
}


class MapDataSource:NSObject{
    
    private var search:MKLocalSearch? =  nil
    private var searchCompleter = MKLocalSearchCompleter()
    private var places = [MKLocalSearchCompletion]()
    
    weak var delegate:MapDataSourceDelegate?
    
    override init() {
        super.init()
        searchCompleter.delegate = self
        searchCompleter.filterType = .locationsOnly
    }
    
    func locationCount() -> Int {
        return places.count
    }
    
    func locationAt(index:IndexPath) -> MKLocalSearchCompletion{
        
        return places[index.row]
    }
}

extension MapDataSource:CLLocationManagerDelegate{
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch  status {
        case .authorizedAlways, .authorizedWhenInUse:
            
            manager.requestLocation()
        default:
            break
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error.localizedDescription)
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        guard let location = locations.first else {return}
        
//        searchCompleter.region = MKCoordinateRegionMakeWithDistance(location.coordinate, 150, 150)
        searchCompleter.filterType = .locationsOnly

        
        
    }
    
}
extension MapDataSource:UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let count = locationCount()
        return count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        let item = locationAt(index: indexPath)
        cell.textLabel?.text = item.title
        cell.detailTextLabel?.text = item.subtitle
        
        return cell
    }
    

}

extension MapDataSource:UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = locationAt(index: indexPath)
        let request = MKLocalSearchRequest()
        print("subtitle \(item.subtitle)")
        request.naturalLanguageQuery = item.title
        let search = MKLocalSearch(request: request)
        search.start { (response, error) in

            guard let response = response else {return}
            guard let item = response.mapItems.first else {return}
            
            //let name = item.placemark.title
            let name = item.name
            let long = item.placemark.coordinate.longitude
            let lat = item.placemark.coordinate.latitude
            
            self.delegate!.setCity(name: name, long: long, lat: lat)
        }
    }
}


extension MapDataSource:MKLocalSearchCompleterDelegate{
    
    func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
        places = completer.results
        delegate?.refreshData()
    }
    
    func completer(_ completer: MKLocalSearchCompleter, didFailWithError error: Error) {
    }
}


extension MapDataSource:UISearchBarDelegate{
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchCompleter.queryFragment = searchText
    }
}
