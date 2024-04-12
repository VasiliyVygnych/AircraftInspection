//
//  FlightsBuilder.swift
//  Aircraft inspection
//
//  Created by Vasiliy Vygnych on 09.04.2024.
//

import UIKit

class FlightsBuilder: FlightsBuilderProtocol {
    
    var main: FlightsController?
    
//MARK: createAddAircraftInspectionView
    func createAddAircraftInspectionView(coordinator: FlightsCoordinatorProtocol) -> UIViewController {
        let controller = AddAircraftInspection()
        var viewModel: FlightsVMProtocol = FlightsViewModel()
        let coreManager: CoreDataManagerProtocol = CoreDataManager()
        controller.delegate = main
        controller.coreManager = coreManager
        controller.viewModel = viewModel
        viewModel.coordinator = coordinator
        return controller
    }
//MARK: createAircraftInspectionView
    func createAircraftInspectionView(coordinator: FlightsCoordinatorProtocol,
                                      model: FlightsList?) -> UIViewController {
        let controller = AircraftInspection()
        var viewModel: FlightsVMProtocol = FlightsViewModel()
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
        let viewModel: SettingsViewModelProtocol = SettingsViewModel()
        controller.viewModel = viewModel
        return controller
    }
}
