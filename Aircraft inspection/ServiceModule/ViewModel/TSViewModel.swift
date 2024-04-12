//
//  TSViewModel.swift
//  Aircraft inspection
//
//  Created by Vasiliy Vygnych on 29.03.2024.
//

import UIKit

class TSViewModel: TSViewModelProtocol {

    var coordinator: TSCoordinatorProtocol?
    
    
    func setMainController(controller: TechnicalServiceController) {
        coordinator?.setMainController(controller: controller)
    }

//MARK: navigation
    func presentAddingAirplaneCardView() {
        coordinator?.presentAddingAirplaneCardView()
    }
    func presentEditingAirplaneCardView(model: AirplaneList?) {
        coordinator?.presentEditingAirplaneCardView(model: model)
    }
    func showDeailAirplaneCard(model: AirplaneList?) {
        coordinator?.showDeailAirplaneCard(model: model)
    }
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
