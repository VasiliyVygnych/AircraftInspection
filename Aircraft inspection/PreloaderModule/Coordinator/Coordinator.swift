//
//  Coordinator.swift
//  Aircraft inspection
//
//  Created by Vasiliy Vygnych on 29.03.2024.
//

import UIKit

class Coordinator: CoordinatorProtocol {
    
    var navigationController: UINavigationController?
    var assembler: AssemblerBuilderProtocol
    
    init(navigationController: UINavigationController?,
         assembler: AssemblerBuilderProtocol = AssemblerBuilder()) {
        self.navigationController = navigationController
        self.assembler = assembler
    }
    
//MARK: initialView
    func initialView() {
        if let navigationController = navigationController {
            navigationController.viewControllers = [assembler.createLoaderController(coordinator: self)]
        }
    }
//MARK: showFirstController
    func showFirstController() {
        if let navigationController = navigationController {
            navigationController.pushViewController(assembler.createFirstController(coordinator: self),
                                                    animated: true)
        }
    }
//MARK: showSecondController
    func showSecondController() {
        if let navigationController = navigationController {
            navigationController.pushViewController(assembler.createSecondController(coordinator: self),
                                                    animated: true)
        }
    }
//MARK: showThirdController
    func showThirdController() {
        if let navigationController = navigationController {
            navigationController.pushViewController(assembler.createThirdController(coordinator: self),
                                                    animated: true)
        }
    }
//MARK: showTabBarController
    func showTabBarController() {
        if let navigationController = navigationController {
            DispatchQueue.main.async {
                navigationController.isNavigationBarHidden = true
                let view = self.assembler.createTabBarController(coordinator: self)
                navigationController.pushViewController(view,
                                                        animated: false)
            }
        }
    }
}
