//
//  AnalyticsViewModel.swift
//  Aircraft inspection
//
//  Created by Vasiliy Vygnych on 09.04.2024.
//

import UIKit

class AnalyticsViewModel: AnalyticsVMProtocol {
    
    var coordinator: AnalyticsCoordinatorProtocol?
    
    func setMainController(controller: AnalyticsController) {
        coordinator?.setMainController(controller: controller)
    }
    func presentDetailAnalytics(model: FlightsList?) {
        coordinator?.presentDetailAnalytics(model: model)
    }
    func presentSettingsController() {
        coordinator?.presentSettingsController()
    }
}
