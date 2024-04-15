//
//  MonitoringAssemblerBuilder.swift
//  Aircraft inspection
//
//  Created by Vasiliy Vygnych on 08.04.2024.
//

import UIKit

class MonitoringAssemblerBuilder: MonitoringBuilderProtocol {
    
    var main: MonitoringController?
    
//MARK: createAddingMonitoringCardView
    func createAddingMonitoringCardView(coordinator: MonitoringCoordinatorProtocol) -> UIViewController {
        let controller = AddingMonotoringCard()
        var viewModel: MonitoringVMProtocol = MonitoringViewModel()
        let coreManager: CoreDataManagerProtocol = CoreDataManager()
        controller.delegate = main
        controller.coreManager = coreManager
        controller.viewModel = viewModel
        viewModel.coordinator = coordinator
        return controller
    }
//MARK: createEditingMonotoringCard
    func createEditingMonotoringCard(coordinator: MonitoringCoordinatorProtocol,
                                       model: MonitoringList?) -> UIViewController {
        let controller = EditingMonotoringCard()
        var viewModel: MonitoringVMProtocol = MonitoringViewModel()
        let coreManager: CoreDataManagerProtocol = CoreDataManager()
        controller.delegate = main
        controller.coreManager = coreManager
        controller.viewModel = viewModel
        controller.model = model
        viewModel.coordinator = coordinator
        return controller
    }
//MARK: createDetailMonotoringCard
    func createDetailMonotoringCard(coordinator: MonitoringCoordinatorProtocol,
                                 model: MonitoringList?) -> UIViewController {
        let controller = DetailMonotoringCard()
        var viewModel: MonitoringVMProtocol = MonitoringViewModel()
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
