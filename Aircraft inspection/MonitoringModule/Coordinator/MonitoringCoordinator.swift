//
//  MonitoringCoordinator.swift
//  Aircraft inspection
//
//  Created by Vasiliy Vygnych on 08.04.2024.
//

import UIKit

class MonitoringCoordinator: MonitoringCoordinatorProtocol {
    
    var navigationController: UINavigationController?
    var assembler: MonitoringBuilderProtocol
    
    init(navigationController: UINavigationController?,
         assembler: MonitoringBuilderProtocol = MonitoringAssemblerBuilder()) {
        self.navigationController = navigationController
        self.assembler = assembler
    }
    
    
    func setMainController(controller: MonitoringController) {
        assembler.main = controller
    }
//MARK: presentAddingMonitoringCardView
    func presentAddingMonitoringCardView() {
        if let navigationController = navigationController {
            navigationController.present(assembler.createAddingMonitoringCardView(coordinator: self),
                                         animated: true)
        }
    }
//MARK: presentEditingMonotoringCardView
    func presentEditingMonotoringCardView(model: MonitoringList?) {
        if let navigationController = navigationController {
            navigationController.present(assembler.createEditingMonotoringCard(coordinator: self,
                                                                               model: model),
                                         animated: true)
        }
    }
//MARK: showDeailAirplaneCard
    func showDeailMonitoringCard(model: MonitoringList?) {
        if let navigationController = navigationController {
            navigationController.present(assembler.createDetailMonotoringCard(coordinator: self,
                                                                              model: model),
                                         animated: true)
        }
    }
//MARK: presentSettingsController
    func presentSettingsController() {
        if let navigationController = navigationController {
            let controller = assembler.createSettingsController()
            if let sheetController = controller.sheetPresentationController {
                sheetController.detents = [.medium(),
                                           .large()]
            }
            navigationController.present(controller,
                                         animated: true)
        }
    }
}
