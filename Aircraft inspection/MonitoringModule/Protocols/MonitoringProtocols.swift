//
//  MonitoringProtocols.swift
//  Aircraft inspection
//
//  Created by Vasiliy Vygnych on 08.04.2024.
//

import UIKit

protocol MonitoringVCDelegate: AnyObject {
    func reloadData()
}

protocol MonitoringVMProtocol {
    var coordinator: MonitoringCoordinatorProtocol? { get set }
    func presentAddingMonitoringCardView()
    func presentEditingMonotoringCardView(model: MonitoringList?)
    func showDeailMonitoringCard(model: MonitoringList?)
    func presentSettingsController()
    func validateCount(text: String,
                       minimumCount: Int) -> Bool
    func clickAnimate(view: UIView)
    func setMainController(controller: MonitoringController)
}

protocol MonitoringBuilderProtocol {
    var main: MonitoringController? { get set }
    func createAddingMonitoringCardView(coordinator: MonitoringCoordinatorProtocol) -> UIViewController
    func createEditingMonotoringCard(coordinator: MonitoringCoordinatorProtocol,
                                       model: MonitoringList?) -> UIViewController
    func createDetailMonotoringCard(coordinator: MonitoringCoordinatorProtocol,
                                 model: MonitoringList?) -> UIViewController
    func createSettingsController() -> UIViewController
}

protocol MonitoringCoordinatorProtocol {
    func presentAddingMonitoringCardView()
    func presentEditingMonotoringCardView(model: MonitoringList?)
    func showDeailMonitoringCard(model: MonitoringList?)
    func presentSettingsController()
    func setMainController(controller: MonitoringController)
}
