//
//  weatherStylesConfig.swift
//  MyWeatherVersion
//
//  Created by Gabriel Cortinas on 5/31/18.
//  Copyright © 2018 Gabriel Cortinas. All rights reserved.
//

import Foundation
import UIKit



extension UIColor {
    
    class var sunshineWhite:UIColor {
        return UIColor(red: 0xff, green: 0xff, blue: 0xff, alpha: 1)
    }
    
    class var sunshineBlue:UIColor  {
        return UIColor(red: 0xff, green: 0x1c, blue: 0xa8, alpha: 0xf4)
    }
    
    class var sunshinegray:UIColor  {
        return UIColor(red: 100/255, green: 100/255, blue: 100/255, alpha: 1)
    }
}

extension UIFont {
    
    class var robotoTitle:UIFont? {
        return UIFont(name: "RobotoCondensed-Bold.ttf", size: 22)
    }
}
