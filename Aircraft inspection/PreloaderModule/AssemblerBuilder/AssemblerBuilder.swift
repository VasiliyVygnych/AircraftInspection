//
//  AssemblerBuilder.swift
//  Aircraft inspection
//
//  Created by Vasiliy Vygnych on 29.03.2024.
//

import UIKit

class AssemblerBuilder: AssemblerBuilderProtocol {
    
//MARK: createLoaderController
    func createLoaderController(coordinator: CoordinatorProtocol) -> UIViewController {
        let controller = LoaderViewController()
        var viewModel: LoaderViewModelProtocol = LoaderViewModel()
        controller.viewModel = viewModel
        viewModel.coordinator = coordinator
        return controller
    }
//MARK: createFirstController
    func createFirstController(coordinator: CoordinatorProtocol) -> UIViewController {
        let controller = FirstLoaderController()
        var viewModel: LoaderViewModelProtocol = LoaderViewModel()
        controller.viewModel = viewModel
        viewModel.coordinator = coordinator
        return controller
    }
//MARK: createSecondController
    func createSecondController(coordinator: CoordinatorProtocol) -> UIViewController {
        let controller = SecondLoaderController()
        var viewModel: LoaderViewModelProtocol = LoaderViewModel()
        controller.viewModel = viewModel
        viewModel.coordinator = coordinator
        return controller
    }
//MARK: createThirdController
    func createThirdController(coordinator: CoordinatorProtocol) -> UIViewController {
        let controller = ThirdLoaderController()
        var viewModel: LoaderViewModelProtocol = LoaderViewModel()
        controller.viewModel = viewModel
        viewModel.coordinator = coordinator
        return controller
    }
//MARK: createTabBar
    func createTabBarController(coordinator: CoordinatorProtocol) -> UITabBarController {
        let controller = TabBarController()
        return controller
    }
}
