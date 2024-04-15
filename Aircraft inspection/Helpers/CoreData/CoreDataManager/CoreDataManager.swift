//
//  CoreDataManager.swift
//  Aircraft inspection
//
//  Created by Vasiliy Vygnych on 30.03.2024.
//

import CoreData
import UIKit


protocol CoreDataManagerProtocol {
    var context: NSManagedObjectContext { get set }
    var delegat: AppDelegate { get set }
    
//MARK: - AirplaneList
    func deleteАllPlanes()
    func deleteAirplane(id: Int)
    func searchAirplane(name: String) -> AirplaneList?
    func editAirplane(with id: Int,
                    name: String?,
                    model: String?,
                    serialNumber: String?,
                    lastInsp: Date?,
                    upcomingInsp: Date?)
//MARK: - MonitoringList
    func deleteАllMonitoringList()
    func deleteMonitoringList(id: Int)
    func editMonitoringList(with id: Int,
                            weight: Int32,
                            name: String?,
                            airPressure: Int32,
                            engineTemperature: Int32,
                            fuelConsumption: Double,
                            balance: Bool)
//MARK: - FlightsList
    func deleteFlightsList(id: Int)
    func deleteАllFlights()
    func aircraftInspection(with id: Int,
                            date: Date,
                            SC: Bool,
                            EA: Bool,
                            IC: Bool,
                            notes: String?)
    func searchInspectionList(id: Int) -> FlightsList?
}

final class CoreDataManager: CoreDataManagerProtocol {
    
    var delegat: AppDelegate
    var context: NSManagedObjectContext
    
    init() {
        delegat = UIApplication.shared.delegate as! AppDelegate
        context = delegat.persistentContainer.viewContext
    }

//MARK: - AirplaneList
    func editAirplane(with id: Int,
                    name: String?,
                    model: String?,
                    serialNumber: String?,
                    lastInsp: Date?,
                    upcomingInsp: Date?) {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "AirplaneList")
        do {
           guard let data = try? context.fetch(fetchRequest) as? [AirplaneList],
                 let attribute = data.first(where: { $0.id == id }) else { return }
            attribute.name = name
            attribute.model = model
            attribute.serialNumber = serialNumber
            attribute.lastInsp = lastInsp
            attribute.upcomingInsp = upcomingInsp
        }
        delegat.saveContext()
    }
    func deleteАllPlanes() {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "AirplaneList")
        do {
            let data = try? context.fetch(fetchRequest) as? [AirplaneList]
            data?.forEach({ context.delete($0) })
        }
        delegat.saveContext()
    }
    func deleteAirplane(id: Int) {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "AirplaneList")
        do {
            guard let data = try? context.fetch(fetchRequest) as? [AirplaneList],
                  let mark = data.first(where: { $0.id == id }) else { return }
            context.delete(mark)
        }
        delegat.saveContext()
    }
    func searchAirplane(name: String) -> AirplaneList? {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "AirplaneList")
        do {
            let data = try? context.fetch(fetchRequest) as? [AirplaneList]
            return data?.first(where: { $0.name == name })
        }
    }
//MARK: - MonitoringList
    func deleteАllMonitoringList() {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "MonitoringList")
        do {
            let data = try? context.fetch(fetchRequest) as? [MonitoringList]
            data?.forEach({ context.delete($0) })
        }
        delegat.saveContext()
    }
    func deleteMonitoringList(id: Int) {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "MonitoringList")
        do {
            guard let data = try? context.fetch(fetchRequest) as? [MonitoringList],
                  let mark = data.first(where: { $0.id == id }) else { return }
            context.delete(mark)
        }
        delegat.saveContext()
    }
    func editMonitoringList(with id: Int,
                            weight: Int32,
                            name: String?,
                            airPressure: Int32,
                            engineTemperature: Int32,
                            fuelConsumption: Double,
                            balance: Bool) {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "MonitoringList")
        do {
           guard let data = try? context.fetch(fetchRequest) as? [MonitoringList],
                 let attribute = data.first(where: { $0.id == id }) else { return }
            attribute.name = name
            attribute.weight = weight
            attribute.airPressure = airPressure
            attribute.engineTemperature = engineTemperature
            attribute.fuelConsumption = fuelConsumption
            attribute.balance = balance
        }
        delegat.saveContext()
    }
    
//MARK: - FlightsList
    func deleteFlightsList(id: Int) {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "FlightsList")
        do {
            guard let data = try? context.fetch(fetchRequest) as? [FlightsList],
                  let mark = data.first(where: { $0.id == id }) else { return }
            context.delete(mark)
        }
        delegat.saveContext()
    }
    func deleteАllFlights() {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "FlightsList")
        do {
            let data = try? context.fetch(fetchRequest) as? [FlightsList]
            data?.forEach({ context.delete($0) })
        }
        delegat.saveContext()
    }
    func aircraftInspection(with id: Int,
                            date: Date,
                            SC: Bool,
                            EA: Bool,
                            IC: Bool,
                            notes: String?) {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "FlightsList")
        do {
           guard let data = try? context.fetch(fetchRequest) as? [FlightsList],
                 let attribute = data.first(where: { $0.id == id }) else { return }
            attribute.reportFrom = date
            attribute.systAndComp = SC
            attribute.electronicsAvionics = EA
            attribute.identAndCertific = IC
            attribute.notes = notes
        }
        delegat.saveContext()
    }
    func searchInspectionList(id: Int) -> FlightsList? {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "FlightsList")
        do {
            let data = try? context.fetch(fetchRequest) as? [FlightsList]
            return data?.first(where: { $0.id == id })
        }
    }
}
