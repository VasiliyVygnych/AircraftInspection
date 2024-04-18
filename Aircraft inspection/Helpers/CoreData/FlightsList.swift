//
//  FlightsList.swift
//  Aircraft inspection
//
//  Created by Vasiliy Vygnych on 09.04.2024.
//

import Foundation
import CoreData

@objc(FlightsList)
public class FlightsList: NSManagedObject {}

extension FlightsList {
    @NSManaged public var id: Int16
    @NSManaged public var electronicsAvionics: Bool
    @NSManaged public var identAndCertific: Bool
    @NSManaged public var systAndComp: Bool
    @NSManaged public var name: String?
    @NSManaged public var checkBefore: Date?
    @NSManaged public var reportFrom: Date?
    @NSManaged public var notes: String?
}
extension FlightsList : Identifiable {}
