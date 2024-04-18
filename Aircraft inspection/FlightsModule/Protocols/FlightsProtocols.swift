//
//  FlightsProtocols.swift
//  Aircraft inspection
//
//  Created by Vasiliy Vygnych on 09.04.2024.
//

import UIKit

protocol FlightsVCDelegate: AnyObject {
    func reloadData()
}

protocol FlightsVMProtocol {
    var coordinator: FlightsCoordinatorProtocol? { get set }
    func presentAddAircraftInspectionView()
    func presentAircraftInspectionView(model: FlightsList?)
    func presentSettingsController()
    func validateCount(text: String,
                       minimumCount: Int) -> Bool
    func clickAnimate(view: UIView)
    func didSelectButton(selectButton: UIButton,
              button: UIButton,
              label: UILabel,
              selectLabel: UILabel)
    func setMainController(controller: FlightsController)
}

protocol FlightsBuilderProtocol {
    var main: FlightsController? { get set }
    func createAddAircraftInspectionView(coordinator: FlightsCoordinatorProtocol) -> UIViewController
    func createAircraftInspectionView(coordinator: FlightsCoordinatorProtocol,
                                      model: FlightsList?) -> UIViewController
    func createSettingsController() -> UIViewController
}

protocol FlightsCoordinatorProtocol {
    func presentAddAircraftInspectionView()
    func presentAircraftInspectionView(model: FlightsList?)
    func presentSettingsController()
    func setMainController(controller: FlightsController)
}
