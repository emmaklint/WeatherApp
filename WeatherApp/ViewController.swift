//
//  ViewController.swift
//  WeatherApp
//
//  Created by Emma Klint on 2017-12-06.
//  Copyright © 2017 Emma Klint. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    

    

    @IBOutlet weak var dayTableView: UITableView!
    
    let items = ["Item 1", "Item 2", "Item 3", "Item 4", "Item 5", "Item 6", "Item 7",]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dayTableView.delegate = self
        dayTableView.dataSource = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = dayTableView.dequeueReusableCell(withIdentifier: "dayCell")
        cell?.textLabel?.text = items[indexPath.row]
        return cell!
    }


}

