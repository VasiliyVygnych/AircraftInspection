//
//  Protocols.swift
//  Aircraft inspection
//
//  Created by Vasiliy Vygnych on 29.03.2024.
//

import UIKit

protocol TSViewControllerDelegate: AnyObject {
    func reloadData()
}

protocol TSViewModelProtocol {
    var coordinator: TSCoordinatorProtocol? { get set }

    func clickAnimate(view: UIView)
    func validateCount(text: String,
                       minimumCount: Int) -> Bool
    func presentAddingAirplaneCardView()
    func presentEditingAirplaneCardView(model: AirplaneList?)
    func showDeailAirplaneCard(model: AirplaneList?)
    func presentSettingsController()
    func setMainController(controller: TechnicalServiceController)
}

protocol TSAssemblerBuilderProtocol {
    var main: TechnicalServiceController? { get set }
    
    func createAddingAirplaneCardView(coordinator: TSCoordinatorProtocol) -> UIViewController
    func createEditingAirplaneCardView(coordinator: TSCoordinatorProtocol,
                                       model: AirplaneList?) -> UIViewController
    func createDeailAirplaneCard(coordinator: TSCoordinatorProtocol,
                                 model: AirplaneList?) -> UIViewController
    func createSettingsController() -> UIViewController
}

protocol TSCoordinatorProtocol {
    func presentAddingAirplaneCardView()
    func presentEditingAirplaneCardView(model: AirplaneList?)
    func showDeailAirplaneCard(model: AirplaneList?)
    func presentSettingsController()
    func setMainController(controller: TechnicalServiceController)
}
