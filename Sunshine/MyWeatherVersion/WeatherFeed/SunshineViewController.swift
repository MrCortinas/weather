//
//  SunshineViewController.swift
//  MyWeatherVersion
//
//  Created by Gabriel Cortinas on 5/31/18.
//  Copyright © 2018 Gabriel Cortinas. All rights reserved.
//

import Foundation
import UIKit

class SunshineViewController: UITableViewController {
    
    var weatherlisData: [weatherlistData] = []
    let dataManager = WeatherDataManager()
    
    
    override func viewDidLoad() {
        self.navigationController?.navigationBar.backgroundColor = UIColor.sunshineBlue
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if WeatherDataManager.share.weatherData == nil {
            WeatherDataManager.share.loadWeatherData(unit: WeatherDataManager.share.currentUnit) { (weatherData) in
                if let list = weatherData?.list {
                    self.weatherlisData = list
                    self.tableView.reloadData()
                }
            }
        }
        super.viewWillAppear(animated)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return weatherlisData.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        switch indexPath.item {
        case 0:
            return 250
        default:
            return 80
        }
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell
        let weather = weatherlisData[indexPath.item]
        let weatherIconID = weather.weather?.first
        
        if indexPath.item == 0 {
            let todayCell = tableView.dequeueReusableCell(withIdentifier: "todaycell", for: indexPath) as! SunshineTodayCell
            if let iconID = weatherIconID?.icon {
               todayCell.iconImage.image = WeatherDataManager.share.getImage(iconID, ImageStyle: .art)
            }
            todayCell.backgroundColor = UIColor.sunshineBlue
            todayCell.maxTempLabel.text = self.formatTemp(temp: weather.temp?.max)
            todayCell.minTempLabel.text = self.formatTemp(temp: weather.temp?.min)
            todayCell.TodatDateLabel.text = self.dateFormarter(interval: weather.dt, dateFormat: "'Today', MMM d")
            todayCell.weatherStatusLabel.text =  weatherIconID?.main
            
            cell = todayCell
        } else {
            let weatherCell = tableView.dequeueReusableCell(withIdentifier: "weathercell", for: indexPath) as! WeatherViewCell
            var dateformat = "EEEE, MMM d"
            if let iconID = weatherIconID?.icon {
                weatherCell.iconImage.image = WeatherDataManager.share.getImage(iconID, ImageStyle: .ic)
            }
            weatherCell.maxTempLabel.text = self.formatTemp(temp: weather.temp?.max)
            weatherCell.minTempLabel.text = self.formatTemp(temp: weather.temp?.min)
            if indexPath.item == 1 {
                dateformat = "'Tomorrow', MMM d"
            }
            
            weatherCell.DateLabel.text = self.dateFormarter(interval: weather.dt, dateFormat:dateformat )
            weatherCell.weatherStatusLabel.text =  weatherIconID?.main
            cell = weatherCell
        }
        
        return cell
    }
    
     override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        WeatherDataManager.share.currentselectedWeather = weatherlisData[indexPath.item]
        performSegue(withIdentifier: "showDetails", sender: self)
    }
    
    func dateFormarter(interval:Double?,dateFormat:String) -> String {
        let date = NSDate(timeIntervalSince1970: interval ?? 0)
        let formatter = DateFormatter()
        formatter.dateFormat = dateFormat
        let myStringDate = formatter.string(from: date as Date)
        return myStringDate
    }
    
    func formatTemp(temp:Float?) -> String {
        let newTemp:Int = Int(temp ?? 0) 
        return "\(newTemp)°"
    }
    
}
