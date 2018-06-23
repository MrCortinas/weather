//
//  DetailsViewController.swift
//  MyWeatherVersion
//
//  Created by Gabriel Cortinas on 5/30/18.
//  Copyright © 2018 Gabriel Cortinas. All rights reserved.
//

import UIKit
import Foundation
import CoreLocation

class DetailsViewController: UIViewController {

    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var dayLabel: UILabel!
    @IBOutlet var maxTempLabel: UILabel!
    @IBOutlet var minTempLabel: UILabel!
    @IBOutlet var presureLabel: UILabel!
    @IBOutlet var HUminityLabel: UILabel!
    @IBOutlet var weatherStatusLabel: UILabel!
    @IBOutlet var windSpeedLabel: UILabel!
    @IBOutlet var iconImage: UIImageView!
    
    var weather: weatherlistData? = WeatherDataManager.share.currentselectedWeather
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        //create custom button
        let sunbtn = UIButton(type: .custom)
        sunbtn.setImage(UIImage(named: "ic_clear.png"), for: .normal)
        sunbtn.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        sunbtn.addTarget(self, action: #selector(self.shareweather), for: .touchUpInside)
        let item = UIBarButtonItem(customView: sunbtn)
        self.navigationItem.setRightBarButtonItems([item], animated: true)
        //update labels
        dateLabel.text = self.dateFormarter(interval: weather?.dt, dateFormat: "MMM d")
        dayLabel.text = self.dateFormarter(interval: weather?.dt, dateFormat: "EEEE")
        maxTempLabel.text = self.formatTemp(temp: weather?.temp?.max)
        minTempLabel.text = self.formatTemp(temp: weather?.temp?.min)
        minTempLabel.textColor = UIColor.sunshinegray
        presureLabel.text = self.formatPresure(presure:weather?.pressure)
        HUminityLabel.text = "Humidity: \(weather?.humidity ?? 0) %"
        windSpeedLabel.text = self.formatWind(speed: weather?.speed, deg: weather?.deg)
        let weatherIconID = weather?.weather?.first
        if let iconID = weatherIconID?.icon {
           iconImage.image = WeatherDataManager.share.getImage(iconID, ImageStyle: .art)
            weatherStatusLabel.text = weatherIconID?.main
            weatherStatusLabel.textColor = UIColor.sunshinegray
        }
    }
    
    //helper metods mostly text format
    
    func dateFormarter(interval:Double?,dateFormat:String) -> String {
        let date = NSDate(timeIntervalSince1970: interval ?? 0)
        let formatter = DateFormatter()
        formatter.dateFormat = dateFormat
        let myStringDate = formatter.string(from: date as Date)
        return myStringDate
    }
    
    
    func formatTemp(temp:Float?) -> String {
        let newValue:Int = Int(temp ?? 0)
        return "\(newValue)°"
    }
    
    func formatWind(speed:Float?,deg:Int?) -> String {
        let newValue:Int = Int(speed ?? 0)
        let directions = ["N", "NE", "E", "SE", "S", "SW", "W", "NW"]
        let heading = Double(deg ?? 0)
        let index = Int((heading + 22.5) / 45.0) & 7
        
        return "Wind: \(newValue)km/h \(directions[index])"
    }
    
    func formatPresure(presure:Float?) -> String {
        let newValue:Int = Int(presure ?? 0)
        return "Pressure: \(newValue) hPa"
    }
    
    @objc func shareweather()  {
        var elementsToSend:Array<Any> = []
        let weatherText = "\(weatherStatusLabel.text ?? ""),\n\(dateLabel.text ?? ""),\n\(dayLabel.text ?? ""),\n MaxTemp:\(maxTempLabel.text ?? ""),\nMinTemp\(minTempLabel.text ?? ""),\n\(presureLabel.text ?? ""),\n\(HUminityLabel.text ?? ""),\n\(windSpeedLabel.text ?? "")"
        // If you want to put an image
        if let image : UIImage = iconImage.image {
            elementsToSend.append(image)
        }
        elementsToSend.append(weatherText as Any)
        
        let activityViewController : UIActivityViewController = UIActivityViewController(
            activityItems: [elementsToSend], applicationActivities: nil)
        
        // This lines is for the popover you need to show in iPad
        activityViewController.popoverPresentationController?.sourceView = self.navigationItem.rightBarButtonItem?.customView
        
        // This line remove the arrow of the popover to show in iPad
        activityViewController.popoverPresentationController?.permittedArrowDirections = UIPopoverArrowDirection.any
        activityViewController.popoverPresentationController?.sourceRect = CGRect(x: 150, y: 150, width: 0, height: 0)
        
        // Anything you want to exclude
        activityViewController.excludedActivityTypes = [
            UIActivityType.postToWeibo,
            UIActivityType.print,
            UIActivityType.assignToContact,
            UIActivityType.saveToCameraRoll,
            UIActivityType.addToReadingList,
            UIActivityType.postToFlickr,
            UIActivityType.postToVimeo,
            UIActivityType.postToTencentWeibo
        ]
        self.present(activityViewController, animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

