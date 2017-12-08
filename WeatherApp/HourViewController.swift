//
//  HourViewController.swift
//  WeatherApp
//
//  Created by Emma Klint on 2017-12-07.
//  Copyright © 2017 Emma Klint. All rights reserved.
//

import UIKit

class HourViewController: UIViewController {
    
    @IBOutlet weak var testLabel: UILabel!
    var day : String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        testLabel.text = day
        self.title = day

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
