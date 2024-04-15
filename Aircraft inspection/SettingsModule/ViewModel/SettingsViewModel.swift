//
//  SettingsViewModel.swift
//  Aircraft inspection
//
//  Created by Vasiliy Vygnych on 10.04.2024.
//

import UIKit
import StoreKit

final class SettingsViewModel: SettingsViewModelProtocol {
    
    var view: SettingsControllerDelegate?
    var network: NetworkProtocol?
    
    func requestUsagePolicy() {
        network?.requestUsagePolicy(completion: { [ weak self ] request in
            DispatchQueue.main.async {
                self?.view?.setRequest(request: request)
            }
        })
    }
    func requestSupport() {
        network?.requestSupport(completion: { [ weak self ] request in
            DispatchQueue.main.async {
                self?.view?.setRequest(request: request)
            }
        })
    }
//MARK: Share App
    func shareApp() {
        print("Share App")
    }
    //MARK: Rate App
    func rateApp() {
        SKStoreReviewController.requestReviewInCurrentScene()
    }
//MARK: clickAnimate
    func clickAnimate(view: UIView) {
        UIView.animate(withDuration: 0.2,
                       delay: 0,
                       options: .curveEaseOut,
                       animations: {
            view.transform = CGAffineTransform(scaleX: 0.97,
                                               y: 0.97)
            view.backgroundColor = .darkGray
        }, completion: { finished in
            UIView.animate(withDuration: 0.3,
                           delay: 0,
                           options: .curveEaseOut,
                           animations: {
                view.transform = CGAffineTransform(scaleX: 1,
                                                   y: 1)
                view.backgroundColor = UIColor(named: "basikGray")
            })
        })
    }
}
