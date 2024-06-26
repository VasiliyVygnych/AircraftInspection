//
//  AnalyticsBuilder.swift
//  Aircraft inspection
//
//  Created by Vasiliy Vygnych on 09.04.2024.
//

import UIKit

class AnalyticsBuilder: AnalyticsBuilderProtocol {
    
    var main: AnalyticsController?
    
//MARK: createDetailAnalytics
    func createDetailAnalytics(coordinator: AnalyticsCoordinatorProtocol,
                               model: FlightsList?) -> UIViewController {
        let controller = DetailAnalyticsController()
        var viewModel: AnalyticsVMProtocol = AnalyticsViewModel()
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
