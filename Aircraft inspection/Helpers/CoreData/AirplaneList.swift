//
//  AirplaneList .swift
//  Aircraft inspection
//
//  Created by Vasiliy Vygnych on 30.03.2024.


import Foundation
import CoreData

@objc(AirplaneList)
public class AirplaneList: NSManagedObject {}

extension AirplaneList {
    @NSManaged public var id: Int16
    @NSManaged public var lastInsp: Date?
    @NSManaged public var model: String?
    @NSManaged public var name: String?
    @NSManaged public var serialNumber: String?
    @NSManaged public var upcomingInsp: Date?
}
extension AirplaneList : Identifiable {}
