//
//  MonitoringViewModel.swift
//  Aircraft inspection
//
//  Created by Vasiliy Vygnych on 08.04.2024.
//

import UIKit

class MonitoringViewModel: MonitoringVMProtocol {
    
    var coordinator: MonitoringCoordinatorProtocol? 
    
    func setMainController(controller: MonitoringController) {
        coordinator?.setMainController(controller: controller)
    }
//MARK: presentAddingMonitoringCardView
    func presentAddingMonitoringCardView() {
        coordinator?.presentAddingMonitoringCardView()
    }
//MARK: presentEditingMonotoringCardView
    func presentEditingMonotoringCardView(model: MonitoringList?) {
        coordinator?.presentEditingMonotoringCardView(model: model)
    }
//MARK: showDeailMonitoringCard
    func showDeailMonitoringCard(model: MonitoringList?) {
        coordinator?.showDeailMonitoringCard(model: model)
    }
//MARK: presentSettingsController
    func presentSettingsController() {
        coordinator?.presentSettingsController()
    }
//MARK: validateCount
    func validateCount(text: String,
                       minimumCount: Int) -> Bool {
        guard text.count >= minimumCount else {
            return false
        }
        return true
    }
//MARK: clickAnimate
    func clickAnimate(view: UIView) {
        UIView.animate(withDuration: 0.2,
                       delay: 0,
                       options: .curveEaseOut,
                       animations: {
            view.transform = CGAffineTransform(scaleX: 0.95,
                                               y: 0.95)
        }, completion: { finished in
            UIView.animate(withDuration: 0.3,
                           delay: 0,
                           options: .curveEaseOut,
                           animations: {
                view.transform = CGAffineTransform(scaleX: 1,
                                                   y: 1)
            })
        })
    }
}
