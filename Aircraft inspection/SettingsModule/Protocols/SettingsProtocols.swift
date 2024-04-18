//
//  SettingsProtocols.swift
//  Aircraft inspection
//
//  Created by Vasiliy Vygnych on 10.04.2024.
//

import UIKit

protocol SettingsControllerDelegate {
    func setRequest(request: URLRequest)
}

protocol SettingsViewModelProtocol {
    var view: SettingsControllerDelegate? { get set }
    var network: NetworkProtocol? { get set }
    func shareApp() -> UIActivityViewController
    func rateApp()
    func clickAnimate(view: UIView)
    func requestUsagePolicy()
    func requestSupport()
}

protocol NetworkProtocol {
    func requestUsagePolicy(completion: @escaping (URLRequest) -> Void)
    func requestSupport(completion: @escaping (URLRequest) -> Void)
}
