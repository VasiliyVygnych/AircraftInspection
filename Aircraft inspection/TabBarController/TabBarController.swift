//
//  TabBar.swift
//  Aircraft inspection
//
//  Created by Vasiliy Vygnych on 29.03.2024.
//

import UIKit

class TabBarController: UITabBarController {
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBar.tintColor = UIColor(named: "basikRed")
        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor(named: "darkGrayColor")
        UITabBar.appearance().standardAppearance = appearance
        UITabBar.appearance().scrollEdgeAppearance = appearance
        self.viewControllers = [createTSСontroller(),
                                createMonitoringController(),
                                createFlightsController(),
                                createddAnalyticsController()]
    }
//MARK: createTSСontroller
    func createTSСontroller() -> UINavigationController {
        let controller = TechnicalServiceController()
        var viewModel: TSViewModelProtocol = TSViewModel()
        let test = AddingAirplaneCard()
        let navController = UINavigationController(rootViewController: controller)
        let coordinator: TSCoordinatorProtocol = TSCoordinator(navigationController: navController)
        let coreManager: CoreDataManagerProtocol = CoreDataManager()
        controller.viewModel = viewModel
        controller.coreManager = coreManager
        viewModel.coordinator = coordinator
        test.delegate = controller
        controller.tabBarItem = UITabBarItem(title: "Airplan",
                                       image: UIImage(named: "airplan"),
                                       tag: 0)
        return navController
    }
//MARK: createMonitoringController
    func createMonitoringController() -> UINavigationController {
        let controller = MonitoringController()
        var viewModel: MonitoringVMProtocol = MonitoringViewModel()
        let navController = UINavigationController(rootViewController: controller)
        let coordinator: MonitoringCoordinatorProtocol = MonitoringCoordinator(navigationController: navController)
        let coreManager: CoreDataManagerProtocol = CoreDataManager()
        controller.coreManager = coreManager
        controller.viewModel = viewModel
        viewModel.coordinator = coordinator
        controller.tabBarItem = UITabBarItem(title: "Monitoring",
                                       image: UIImage(named: "monitoring"),
                                       tag: 1)
        return navController
    }
//MARK: createFlightsController 
    func createFlightsController() -> UINavigationController {
        let controller = FlightsController()
        var viewModel: FlightsVMProtocol = FlightsViewModel()
        let navController = UINavigationController(rootViewController: controller)
        let coordinator: FlightsCoordinatorProtocol = FlightsCoordinator(navigationController: navController)
        let coreManager: CoreDataManagerProtocol = CoreDataManager()
        controller.viewModel = viewModel
        controller.coreManager = coreManager
        viewModel.coordinator = coordinator
        controller.tabBarItem = UITabBarItem(title: "Flights",
                                       image: UIImage(named: "flights"),
                                       tag: 2)
        return navController
    }
//MARK: createddAnalyticsController
    func createddAnalyticsController() -> UINavigationController {
        let controller = AnalyticsController()
        var viewModel: AnalyticsVMProtocol = AnalyticsViewModel()
        let navController = UINavigationController(rootViewController: controller)
        let coordinator: AnalyticsCoordinatorProtocol = AnalyticsCoordinator(navigationController: navController)
        let coreManager: CoreDataManagerProtocol = CoreDataManager()
        controller.coreManager = coreManager
        controller.viewModel = viewModel
        viewModel.coordinator = coordinator
        controller.tabBarItem = UITabBarItem(title: "Analytics",
                                       image: UIImage(named: "analytics"),
                                       tag: 3)
        return navController
    }
}
