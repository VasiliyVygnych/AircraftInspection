//
//  FlightsCoordinator.swift
//  Aircraft inspection
//
//  Created by Vasiliy Vygnych on 09.04.2024.
//

import UIKit

class FlightsCoordinator: FlightsCoordinatorProtocol {
    
    var navigationController: UINavigationController?
    var assembler: FlightsBuilderProtocol
    
    init(navigationController: UINavigationController?,
         assembler: FlightsBuilderProtocol = FlightsBuilder()) {
        self.navigationController = navigationController
        self.assembler = assembler
    }
    
//MARK: setMainController/
    func setMainController(controller: FlightsController) {
        assembler.main = controller
    }
//MARK: presentAddAircraftInspectionView
    func presentAddAircraftInspectionView() {
        if let navigationController = navigationController {
            navigationController.present(assembler.createAddAircraftInspectionView(coordinator: self),
                                         animated: true)
        }
    }
//MARK: presentAircraftInspectionView
    func presentAircraftInspectionView(model: FlightsList?) {
        if let navigationController = navigationController {
            navigationController.present(assembler.createAircraftInspectionView(coordinator: self,
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
