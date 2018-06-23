//
//  WeatherIconImage.swift
//  MyWeatherVersion
//
//  Created by Gabriel Cortinas on 5/31/18.
//  Copyright © 2018 Gabriel Cortinas. All rights reserved.
//

import Foundation
import UIKit

enum iconImage:String {
    case clear
    case light_clouds
    case clouds
    case light_rain
    case rain
    case storm
    case snow
    case fog
    case none
    
    func artImage() -> UIImage? {
        let imageName:String = self.rawValue
        return UIImage(named: "art_\(imageName).png")
    }
    
    func icImage() -> UIImage? {
        if self == .clouds {
            return UIImage(named: "ic_cloudy.png")
        }
        let imageName:String = self.rawValue
        return UIImage(named: "ic_\(imageName).png")
    }
    
}

protocol WeatherImageProtocols {
    func getMyWeatherImage(_ imageID:String) -> iconImage
}

class WeatherIconImage: WeatherImageProtocols {
    /*maps-transform image id value into enum to get image file*/
    func getMyWeatherImage(_ imageID: String) -> iconImage {
        switch imageID {
        case "01d","01n": return iconImage.clear
        case "02d","02n": return iconImage.light_clouds
        case "03d","03n","04d","04n": return iconImage.clouds
        case "09d","09n": return iconImage.light_rain
        case "10d","10n": return iconImage.rain
        case "11d","11n": return iconImage.storm
        case "13d","13n": return iconImage.snow
        case "50d","50n": return iconImage.fog
        default: return iconImage.none
        }
    }
    
}
