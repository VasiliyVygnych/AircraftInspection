//
//  AnalyticsProtocols.swift
//  Aircraft inspection
//
//  Created by Vasiliy Vygnych on 09.04.2024.
//

import UIKit

protocol AnalyticsVCDelegate: AnyObject {
    func reloadData()
}

protocol AnalyticsVMProtocol {
    var coordinator: AnalyticsCoordinatorProtocol? { get set }
    
    func presentDetailAnalytics(model: FlightsList?)
    func presentSettingsController()
    func setMainController(controller: AnalyticsController)
}

protocol AnalyticsBuilderProtocol {
    var main: AnalyticsController? { get set }
    func createDetailAnalytics(coordinator: AnalyticsCoordinatorProtocol,
                               model: FlightsList?) -> UIViewController
    func createSettingsController() -> UIViewController
}

protocol AnalyticsCoordinatorProtocol {
    func presentDetailAnalytics(model: FlightsList?)
    func presentSettingsController()
    func setMainController(controller: AnalyticsController)
}
