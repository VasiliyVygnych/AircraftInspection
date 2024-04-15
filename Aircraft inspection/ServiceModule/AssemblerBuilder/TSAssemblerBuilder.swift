//
//  TSAssemblerBuilder.swift
//  Aircraft inspection
//
//  Created by Vasiliy Vygnych on 29.03.2024.
//

import UIKit

class TSAssemblerBuilder: TSAssemblerBuilderProtocol {
    
    var main: TechnicalServiceController?
    
//MARK: AddingAirplaneCard
    func createAddingAirplaneCardView(coordinator: TSCoordinatorProtocol) -> UIViewController {
        let controller = AddingAirplaneCard()
        var viewModel: TSViewModelProtocol = TSViewModel()
        let coreManager: CoreDataManagerProtocol = CoreDataManager()
        controller.delegate = main
        controller.viewModel = viewModel
        controller.coreManager = coreManager
        viewModel.coordinator = coordinator
        return controller
    }
//MARK: EditingAirplaneCard
    func createEditingAirplaneCardView(coordinator: TSCoordinatorProtocol,
                                       model: AirplaneList?) -> UIViewController {
        let controller = EditingAirplaneCard()
        var viewModel: TSViewModelProtocol = TSViewModel()
        let coreManager: CoreDataManagerProtocol = CoreDataManager()
        controller.delegate = main
        controller.coreManager = coreManager
        controller.viewModel = viewModel
        controller.model = model
        viewModel.coordinator = coordinator
        return controller
    }
//MARK: createDeailAirplaneCard
    func createDeailAirplaneCard(coordinator: TSCoordinatorProtocol,
                                 model: AirplaneList?) -> UIViewController {
        let controller = DetailAirplaneCard()
        var viewModel: TSViewModelProtocol = TSViewModel()
        let coreManager: CoreDataManagerProtocol = CoreDataManager()
        controller.delegate = main
        controller.coreManager = coreManager
        controller.viewModel = viewModel
        controller.model = model
        viewModel.coordinator = coordinator
        return controller
    }
//MARK: createSettingsController
    func createSettingsController() -> UIViewController {
        let controller = SettingsController()
        var viewModel: SettingsViewModelProtocol = SettingsViewModel()
        let navController = UINavigationController(rootViewController: controller)
        let network: NetworkProtocol = Network()
        controller.viewModel = viewModel
        viewModel.network = network
        return navController
    }
}
