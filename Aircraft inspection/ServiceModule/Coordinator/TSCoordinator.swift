//
//  TSCoordinator.swift
//  Aircraft inspection
//
//  Created by Vasiliy Vygnych on 29.03.2024.
//

import UIKit

class TSCoordinator: TSCoordinatorProtocol {
    
    var navigationController: UINavigationController?
    var assembler: TSAssemblerBuilderProtocol
    
    init(navigationController: UINavigationController?,
         assembler: TSAssemblerBuilderProtocol = TSAssemblerBuilder()) {
        self.navigationController = navigationController
        self.assembler = assembler
    }
    
//MARK: setMainController
    func setMainController(controller: TechnicalServiceController) {
        assembler.main = controller
    }
//MARK: presentAddingAirplaneCardView
    func presentAddingAirplaneCardView() {
        if let navigationController = navigationController {
            let view = assembler.createAddingAirplaneCardView(coordinator: self)
            view.modalPresentationStyle = .formSheet
            navigationController.present(view,
                                         animated: true)
        }
    }
//MARK: presentEditingAirplaneCardView
    func presentEditingAirplaneCardView(model: AirplaneList?) {
        if let navigationController = navigationController {
            navigationController.present(assembler.createEditingAirplaneCardView(coordinator: self,
                                                                                 model: model),
                                         animated: true)
        }
    }
//MARK: showDeailAirplaneCard
    func showDeailAirplaneCard(model: AirplaneList?) {
        if let navigationController = navigationController {
            navigationController.present(assembler.createDeailAirplaneCard(coordinator: self,
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
