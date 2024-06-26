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
    
//MARK: requestUsagePolicy
    func requestUsagePolicy() {
        network?.requestUsagePolicy(completion: { [ weak self ] request in
            DispatchQueue.main.async {
                self?.view?.setRequest(request: request)
            }
        })
    }
//MARK: requestSupport
    func requestSupport() {
        network?.requestSupport(completion: { [ weak self ] request in
            DispatchQueue.main.async {
                self?.view?.setRequest(request: request)
            }
        })
    }
//MARK: Share App
    func shareApp() -> UIActivityViewController {
        let url = URL(string: "https://apps.apple.com/us/app/id0000000")!
        let vc = UIActivityViewController(activityItems: [url],
                                          applicationActivities: nil)
        return vc
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
