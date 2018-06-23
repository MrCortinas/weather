//
//  MyWeatherVersionTests.swift
//  MyWeatherVersionTests
//
//  Created by Gabriel Cortinas on 5/30/18.
//  Copyright © 2018 Gabriel Cortinas. All rights reserved.
//

import XCTest
@testable import MyWeatherVersion

class MockHttpClient:WearherHTTPClient  {
    override func getWeatherData(url: URL, completionHandler: @escaping (weatherData?) -> Void) {
        completionHandler(nil)
    }
}


class MyWeatherVersionTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testEmptyConfigurationData() {
        let httpCLient = MockHttpClient()
        let datamanager = WeatherDataManager.init(httpCLient, customURL: "https://someURL")
        
        let array =  datamanager.getConfiguratioFeatures()
        XCTAssert(array.count == 1, "we only need to have 1 since data source is empty")
    }
    
    func testbadEmptyImage() {
        let httpCLient = MockHttpClient()
        let datamanager = WeatherDataManager.init(httpCLient, customURL: "https://someURL")
        
        let badImage = datamanager.getImage("badImage", ImageStyle: .ic)
        XCTAssertNotNil(badImage,"this need to privide a default value")
    }
    
    func testImmageMapping() {
        let weatherImage = WeatherIconImage()
        let mapIcons = ["01d","01n","02d","02n","03d","03n","04d","04n","09d","09n","10d","10n","11d","11n","13d","13n","50d","50n"]
        
        for icons in mapIcons {
           XCTAssert( weatherImage.getMyWeatherImage(icons) != .none,"mapping all availble images")
        }
        
        XCTAssert( weatherImage.getMyWeatherImage("bad Name") == .none,"non map image")
    }
    
}
