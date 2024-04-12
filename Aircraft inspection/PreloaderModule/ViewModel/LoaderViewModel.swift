//
//  LoaderViewModel.swift
//  Aircraft inspection
//
//  Created by Vasiliy Vygnych on 29.03.2024.
//

import UIKit

class LoaderViewModel: LoaderViewModelProtocol {
    
    var coordinator: CoordinatorProtocol?
    
    func showFirstController() {
        coordinator?.showFirstController()
    }
    func showSecondController() {
        coordinator?.showSecondController()
    }
    func showThirdController() {
        coordinator?.showThirdController()
    }
    func showTabBarController() {
        coordinator?.showTabBarController()
    }
    func clickAnimate(view: UIView) {
        UIView.animate(withDuration: 0.2,
                       delay: 0,
                       options: .curveEaseOut,
                       animations: {
            view.transform = CGAffineTransform(scaleX: 0.90,
                                               y: 0.90)
        }, completion: { finished in
            UIView.animate(withDuration: 0.3,
                           delay: 0,
                           options: .curveEaseOut,
                           animations: {
                view.transform = CGAffineTransform(scaleX: 1,
                                                   y: 1)
            })
        })
    }
}
