//
//  SettingsTableViewController.swift
//  MyWeatherVersion
//
//  Created by Gabriel Cortinas on 5/31/18.
//  Copyright © 2018 Gabriel Cortinas. All rights reserved.
//

import Foundation
import UIKit


class SettingsTableViewController: UITableViewController {
    
    var settingsElements: Array<Any> = []
    
    
    override func viewWillAppear(_ animated: Bool) {
       self.settingsElements = WeatherDataManager.share.getConfiguratioFeatures()
        super.viewWillAppear(animated)
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return settingsElements.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        switch indexPath.item {
        case 0:
            return 90
        default:
            return 60
        }
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.item == 0  {
            let cell = tableView.dequeueReusableCell(withIdentifier: "unitFormatCell", for: indexPath) as! UnitSelectionTableViewCell
            //enable current version
            switch WeatherDataManager.share.currentUnit {
            case .metric: cell.unitSelection.selectedSegmentIndex = 0
            case .imperial: cell.unitSelection.selectedSegmentIndex = 1
            case .kelvin: cell.unitSelection.selectedSegmentIndex = 2
            }
            return cell
        }
        let cell = tableView.dequeueReusableCell(withIdentifier:"infomationCell" , for: indexPath)
  
        if let dict: Dictionary<String, Any> = settingsElements[indexPath.item] as? [String:Any] {
            cell.textLabel?.text = Array(dict.keys).joined(separator: ",")
            cell.detailTextLabel?.text = Array(dict.values).description
        }
        
        return cell
    }
    
    
}

