//
//  Weather+CoreDataProperties.swift
//  
//
//  Created by Gabriel Cortinas on 6/22/18.
//
//  This file was automatically generated and should not be edited.
//

import Foundation
import CoreData


extension Weather {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Weather> {
        return NSFetchRequest<Weather>(entityName: "Weather")
    }


}
