//
//  Protocols.swift
//  Aircraft inspection
//
//  Created by Vasiliy Vygnych on 29.03.2024.
//

import UIKit

protocol LoaderViewModelProtocol {
    var coordinator: CoordinatorProtocol? { get set }
    func showFirstController()
    func showSecondController()
    func showThirdController()
    func showTabBarController()
    func clickAnimate(view: UIView)
}

protocol AssemblerBuilderProtocol {
    func createLoaderController(coordinator: CoordinatorProtocol) -> UIViewController
    func createFirstController(coordinator: CoordinatorProtocol) -> UIViewController
    func createSecondController(coordinator: CoordinatorProtocol) -> UIViewController
    func createThirdController(coordinator: CoordinatorProtocol) -> UIViewController
    func createTabBarController(coordinator: CoordinatorProtocol) -> UITabBarController
}

protocol CoordinatorProtocol {
    func initialView()
    func showFirstController()
    func showSecondController()
    func showThirdController()
    func showTabBarController()
}
