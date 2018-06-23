//
//  UnitSelectionTablrViewCell.swift
//  MyWeatherVersion
//
//  Created by Gabriel Cortinas on 5/31/18.
//  Copyright © 2018 Gabriel Cortinas. All rights reserved.
//

import Foundation
import UIKit

class UnitSelectionTableViewCell: UITableViewCell {
    
    @IBOutlet var unitSelection: UISegmentedControl!
    @IBAction func newUnitValueSelected(_ sender: UISegmentedControl) {    
        switch sender.selectedSegmentIndex {
        case 0: WeatherDataManager.share.currentUnit = .metric
        case 1: WeatherDataManager.share.currentUnit = .imperial
        case 2: WeatherDataManager.share.currentUnit = .kelvin
        default: WeatherDataManager.share.currentUnit = .imperial
        }
        WeatherDataManager.share.weatherData = nil
    }
}
