//
//  FlightsViewModel.swift
//  Aircraft inspection
//
//  Created by Vasiliy Vygnych on 09.04.2024.
//

import UIKit

class FlightsViewModel: FlightsVMProtocol {
    
    var coordinator: FlightsCoordinatorProtocol?
    
    func setMainController(controller: FlightsController) {
        coordinator?.setMainController(controller: controller)
    }
//MARK: presentAddAircraftInspectionView
    func presentAddAircraftInspectionView() {
        coordinator?.presentAddAircraftInspectionView()
    }
//MARK: presentAircraftInspectionView
    func presentAircraftInspectionView(model: FlightsList?) {
        coordinator?.presentAircraftInspectionView(model: model)
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
//MARK: didSelectButton
    func didSelectButton(selectButton: UIButton,
              button: UIButton,
              label: UILabel,
              selectLabel: UILabel) {
        if selectButton.backgroundColor == UIColor(named: "basikGray") {
            clickAnimate(view: selectButton)
            button.backgroundColor = UIColor(named: "basikGray")
            selectButton.backgroundColor = .white
            selectLabel.textColor = .black
            label.textColor = .white
             } else {
                 selectButton.backgroundColor = UIColor(named: "basikGray")
                 selectLabel.textColor = .white
        }
    }
}
