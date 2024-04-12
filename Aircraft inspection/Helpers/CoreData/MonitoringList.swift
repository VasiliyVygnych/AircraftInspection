//
//  MonitoringList.swift
//  Aircraft inspection
//
//  Created by Vasiliy Vygnych on 30.03.2024.
//

import Foundation

import CoreData

@objc(MonitoringList)
public class MonitoringList: NSManagedObject {}

extension MonitoringList {
    
    @NSManaged public var id: Int16
    @NSManaged public var airPressure: Int32
    @NSManaged public var balance: Bool
    @NSManaged public var engineTemperature: Int32
    @NSManaged public var fuelConsumption: Double
    @NSManaged public var name: String?
    @NSManaged public var weight: Int32

}

extension MonitoringList : Identifiable {}
