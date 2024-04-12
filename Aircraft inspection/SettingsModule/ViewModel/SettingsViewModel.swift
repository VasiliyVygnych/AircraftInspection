//
//  SettingsViewModel.swift
//  Aircraft inspection
//
//  Created by Vasiliy Vygnych on 10.04.2024.
//

import UIKit

class SettingsViewModel: SettingsViewModelProtocol {
 
//MARK: Share App
    func shareApp() {
        print("Share App")
    }
    //MARK: Usage Policy
    func usagePolicy() {
        print("Usage Policy")
    }
    //MARK: Rate App
    func rateApp() {
        print("Rate App")
    }
    //MARK: Support
    func support() {
        print("Support")
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
