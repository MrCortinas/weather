//
//  WeatherDataManager.swift
//  MyWeatherVersion
//
//  Created by Gabriel Cortinas on 5/31/18.
//  Copyright © 2018 Gabriel Cortinas. All rights reserved.
//

import Foundation
import UIKit
import CoreLocation

enum ImageStyle {
    case art
    case ic
}

enum unitType:String {
    case imperial
    case metric
    case kelvin
}

protocol WeatherDataManagerProtocols {
    func getImage(_ ImageID: String, ImageStyle:ImageStyle) -> UIImage
    func loadWeatherData(unit: unitType,completionHandler: @escaping (_ jsonData:weatherData?) -> Void)
    func updateWeatherData(unit:unitType,completionHandler: @escaping (_ jsonData:weatherData?) -> Void)
    func getConfiguratioFeatures() -> Array<Any>
}

class WeatherDataManager: WeatherDataManagerProtocols {
    
    static let share = WeatherDataManager()
    public var weatherData:weatherData? = nil
    private var weatherURLString:String
    private let httpClient:WearherHTTPClient
    public var currentselectedWeather: weatherlistData? = nil
    public var currentUnit: unitType = .imperial
    
    // sets of custom init https://api.openweathermap.org/data/2.5/forecast/daily?lat=33.7491&lon=-84.3902&mode=json&cnt=5&units=imperial&apikey=3aa158b2f14a9f493a8c725f8133d704
    init() {
        self.weatherURLString = "https://api.openweathermap.org/data/2.5/forecast/daily?q=Atlanta&mode=json&cnt=5&units=imperial&apikey=3aa158b2f14a9f493a8c725f8133d704"
        self.httpClient = WearherHTTPClient()
        let locManager = CLLocationManager()
        locManager.requestWhenInUseAuthorization()
    }
    // usefull for setting mocks enviroments or changing to a non production enviroment 
    init(_ customHTTPClient:WearherHTTPClient, customURL:String ) {
        self.weatherURLString = customURL
        self.httpClient = customHTTPClient
    }
    
    /*maps your image icon from your weather id*/
    func getImage(_ ImageID: String, ImageStyle:ImageStyle) -> UIImage {
        let icon = WeatherIconImage()
        let image = icon.getMyWeatherImage(ImageID)
        switch ImageStyle {
        case .ic: return image.icImage() ?? UIImage()
        default: return image.artImage() ?? UIImage()
        }
    }
    
    
    /* call for data make sure you only call once  */
    func loadWeatherData(unit: unitType,completionHandler: @escaping (weatherData?) -> Void) {
        let newURL = setupWeatherURL(unit:unit)
        if URL(string: newURL ?? "") != nil {
            self.weatherURLString = newURL ?? ""
        }
        if weatherData == nil {
            if let url = URL(string: weatherURLString) {
                self.httpClient.getWeatherData(url: url) { (jsonData) in
                    self.weatherData = jsonData
                    completionHandler(jsonData)
                }
            } else {
                completionHandler(nil)
            }
        }else{
            completionHandler(self.weatherData)
        }
    }
    
    func updateWeatherData(unit: unitType, completionHandler: @escaping (weatherData?) -> Void) {
        if let url = URL(string: weatherURLString) {
            self.httpClient.getWeatherData(url: url) { (jsonData) in
                self.weatherData = jsonData
                completionHandler(jsonData)
            }
        } else {
            completionHandler(nil)
        }
    }
    
    private func setupWeatherURL(unit: unitType) -> String? {
        let locManager = CLLocationManager()
        var url:String? = nil
        locManager.requestWhenInUseAuthorization()
        var currentLocation: CLLocation!
        
        if( CLLocationManager.authorizationStatus() == .authorizedWhenInUse ||
            CLLocationManager.authorizationStatus() ==  .authorizedAlways){
            currentLocation = locManager.location
            url = "https://api.openweathermap.org/data/2.5/forecast/daily?lat=\(currentLocation.coordinate.latitude)&lon=\(currentLocation.coordinate.longitude)&mode=json&cnt=5&units=\(unit.rawValue)&apikey=3aa158b2f14a9f493a8c725f8133d704"
        } else {
          url = "https://api.openweathermap.org/data/2.5/forecast/daily?q=Atlanta&mode=json&cnt=5&units=\(unit.rawValue)&apikey=3aa158b2f14a9f493a8c725f8133d704"
        }
        return url
    }
    
    func getConfiguratioFeatures() -> Array<Any> {
        var configurations: Array<Any> = []
        configurations.append(currentUnit)
        if let cityInformation = weatherData?.city {
            configurations.append(["Name": cityInformation.name ])
            configurations.append(["id": cityInformation.id ])
            if let coords = cityInformation.coord {
                configurations.append(["lat": coords.lat ])
                configurations.append(["lot": coords.lon ])
            }
            configurations.append(["Country":cityInformation.country])
            configurations.append(["Population":cityInformation.population])
        }
        if weatherData?.cnt != nil {
            configurations.append(["CNT":weatherData?.cnt])
        }
        if weatherData?.cod != nil {
            configurations.append(["CoD":weatherData?.cod])
        }
        if weatherData?.message != nil {
            configurations.append(["message":weatherData?.message])
        }
        return configurations
    }
    
}

