//
//  BaseViewController.swift
//  Aircraft inspection
//
//  Created by Vasiliy Vygnych on 29.03.2024.
//

import UIKit
import SnapKit

class BaseViewController: UIViewController {
    
    let appearance = UINavigationBarAppearance()
    let swipeGesture = UISwipeGestureRecognizer()
    let gestureRecognizer = UITapGestureRecognizer()
    
//MARK: UILabel
    private var navTitle: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.font = .RobotoFlex(ofSize: 20,
                                 weight: ._500)
        label.textAlignment = .center
        return label
    }()
//MARK: UIButton
    private var backButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setBackgroundImage(UIImage(named: "arrow-left"),
                                  for: .normal)
        return button
    }()
//MARK: viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = false
        view.addSubview(backButton)
        view.addSubview(navTitle)
        makeConstraint()
        makeButton()
    }
//MARK: makeConstraint
   private func makeConstraint() {
        backButton.snp.makeConstraints { make in
            make.top.equalTo(20)
            make.width.height.equalTo(32)
            make.left.equalTo(20)
        }
       navTitle.snp.makeConstraints { make in
           make.top.equalTo(20)
           make.centerX.equalToSuperview()
           make.height.equalTo(27)
           make.width.equalTo(120)
       }
    }
//MARK: makeButton
    private func makeButton() {
        backButton.addTarget(self,
                             action: #selector(popView),
                             for: .touchUpInside)
    }
    @objc func popView() {
        dismiss(animated: true)
    }
}
//MARK: - setting up the view
extension BaseViewController {
    func settingUpTheView(_ controller: Controllers) {
        switch controller {
        case .loader:
            view.backgroundColor = UIColor(named: "background")
            backButton.isHidden = true
        case .preloader:
            view.backgroundColor = UIColor(named: "background")
            backButton.isHidden = true
        case .edit:
            navTitle.text = "Edit"
            navTitle.font = .RobotoFlex(ofSize: 20,
                                        weight: ._500)
            view.backgroundColor = UIColor(named: "background")
        case .add:
            navTitle.text = "Add plane"
            view.backgroundColor = UIColor(named: "background")
        case .monitoring:
            view.backgroundColor = UIColor(named: "background")
            backButton.isHidden = true
        case .flights :
            view.backgroundColor = UIColor(named: "background")
            backButton.isHidden = true
        case .analytic:
            view.backgroundColor = UIColor(named: "background")
            backButton.isHidden = true
        case .defaults:
            view.backgroundColor = UIColor(named: "background")
        case .settings:
            view.backgroundColor = UIColor(named: "darkGrayColor")
            navTitle.font = .RobotoFlex(ofSize: 20,
                                        weight: ._500)
            navTitle.text = "Settings"
        case .none:
            view.backgroundColor = UIColor(named: "background")
            backButton.isHidden = true
        }
    }
}
