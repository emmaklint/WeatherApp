//
//  CustomTableViewCell.swift
//  WeatherApp
//
//  Created by Emma Klint on 2017-12-12.
//  Copyright © 2017 Emma Klint. All rights reserved.
//

import UIKit

class CustomTableViewCell: UITableViewCell {

    @IBOutlet weak var dayView: UIView!
    @IBOutlet weak var weekdayLabel: UILabel!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var lineImg: UIImageView!
    @IBOutlet weak var iconLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.layoutMargins = UIEdgeInsets.zero;
        self.preservesSuperviewLayoutMargins = false;
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
