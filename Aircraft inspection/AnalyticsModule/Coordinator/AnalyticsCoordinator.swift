//
//  AnalyticsCoordinator.swift
//  Aircraft inspection
//
//  Created by Vasiliy Vygnych on 09.04.2024.
//

import UIKit

class AnalyticsCoordinator: AnalyticsCoordinatorProtocol {
    
    var navigationController: UINavigationController?
    var assembler: AnalyticsBuilderProtocol
    
    init(navigationController: UINavigationController?,
         assembler: AnalyticsBuilderProtocol = AnalyticsBuilder()) {
        self.navigationController = navigationController
        self.assembler = assembler
    }
    
//MARK: setMainController
    func setMainController(controller: AnalyticsController) {
        assembler.main = controller
    }
//MARK: presentDetailAnalytics
    func presentDetailAnalytics(model: FlightsList?) {
        if let navigationController = navigationController {
            navigationController.present(assembler.createDetailAnalytics(coordinator: self,
                                                                         model: model),
                                         animated: true)
        }
    }
//MARK: presentSettingsController
    func presentSettingsController() {
        if let navigationController = navigationController {
            let controller = assembler.createSettingsController()
            if let sheetController = controller.sheetPresentationController {
                sheetController.detents = [.medium()]
            }
            navigationController.present(controller,
                                         animated: true)
        }
    }
}
