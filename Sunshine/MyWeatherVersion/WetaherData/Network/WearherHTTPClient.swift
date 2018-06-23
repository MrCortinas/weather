//
//  WearherHTTPClient.swift
//  MyWeatherVersion
//
//  Created by Gabriel Cortinas on 5/30/18.
//  Copyright © 2018 Gabriel Cortinas. All rights reserved.
//

import Foundation


struct weatherData: Codable {
    let city:cityData?
    let cod:String?
    let message:Float?
    let cnt:Int?
    let list:[weatherlistData]?
}

struct cityData: Codable {
    let id:Int?
    let name:String?
    let coord:coordData?
    let country:String?
    let population:Double?
}

struct coordData: Codable {
    let lon:Double?
    let lat:Double?
}

struct weatherlistData: Codable {
        let dt:Double?
        let temp:tempData?
        let pressure:Float?
        let humidity:Int?
        let weather:[weatherIconData]?
        let speed:Float?
        let deg:Int?
        let clouds:Int?
        let rain:Float?
}

struct tempData: Codable {
    let day:Float?
    let min:Float?
    let max:Float?
    let night:Float?
    let eve:Float?
    let morn:Float?
}

struct weatherIconData: Codable {
    let id:Int?
    let main:String?
    let description:String?
    let icon:String?
}


protocol WearherHTTPClientProtocols {
    func getWeatherData(url:URL,completionHandler: @escaping (weatherData?) -> Void)
}

class WearherHTTPClient: WearherHTTPClientProtocols {
    func getWeatherData(url:URL,completionHandler: @escaping (weatherData?) -> Void) {
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if error != nil {
                print(error!.localizedDescription)
                completionHandler(nil)
            }
            
            guard let data = data else {
                completionHandler(nil)
                return
            }
            do {
                let UserData = try JSONDecoder().decode(weatherData.self, from: data)
                DispatchQueue.main.async { completionHandler(UserData) }
            } catch let jsonError {
                print(jsonError)
                completionHandler(nil)
            }
            
            }.resume()
    }
}
