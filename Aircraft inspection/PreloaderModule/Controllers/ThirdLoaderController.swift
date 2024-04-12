//
//  ThirdLoaderController.swift
//  Aircraft inspection
//
//  Created by Vasiliy Vygnych on 29.03.2024.
//

import UIKit
import SnapKit

final class ThirdLoaderController: BaseViewController {
    
    var viewModel: LoaderViewModelProtocol?
    var defaults = UserDefaults.standard
    
//MARK: UIImageView
    private var onboardingImageView: UIImageView = {
       let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleAspectFill
        view.image = UIImage(named: "thirdOnboarding")
        return view
    }()
    private var bottomView: UIImageView = {
       let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleAspectFill
        view.image = UIImage(named: "bottomView")
        return view
    }()
    private var progressView: UIImageView = {
       let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleAspectFill
        view.image = UIImage(named: "progressView3")
        return view
    }()
//MARK: UILabel
    private var nameLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.font = .systemFont(ofSize: 28,
                                 weight: .bold)
        label.textAlignment = .left
        label.text = "Nearest flights"
        return label
    }()
    private var titleLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .lightGray
        label.font = .systemFont(ofSize: 17,
                                 weight: .light)
        label.textAlignment = .left
        label.numberOfLines = 0
        label.text = "Fill out the nearest flights to check the aircraft"
        return label
    }()
//MARK: UIButton
    private var beginButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Begin",
                        for: .normal)
        button.backgroundColor = UIColor(named: "basikRed")
        button.layer.cornerRadius = 12
        return button
    }()
//MARK: viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(onboardingImageView)
        view.addSubview(bottomView)
        bottomView.addSubview(nameLabel)
        bottomView.addSubview(titleLabel)
        bottomView.addSubview(progressView)
        view.addSubview(beginButton)
        setupeConstraint()
        setupeButton()
    }
//MARK: viewWillAppear
    override func viewWillAppear(_ animated: Bool) {
        settingUpTheView(.preloader)
        navigationController?.navigationBar.isHidden = true
    }
//MARK: setupeButton
    private func setupeButton() {
        beginButton.addTarget(self,
                              action: #selector(openTabBar),
                              for: .touchUpInside)
    }
    @objc func openTabBar() {
        viewModel?.clickAnimate(view: beginButton)
        viewModel?.showTabBarController()
        defaults.set(true,
                     forKey: "authorization")
    }
//MARK: setupeConstraint
    private func setupeConstraint() {
        onboardingImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(102)
            make.width.equalTo(323)
            make.centerX.equalToSuperview()
            make.height.equalTo(660)
        }
        beginButton.snp.makeConstraints { make in
            make.width.equalTo(144)
            make.height.equalTo(47)
            make.right.equalTo(-30)
            make.bottom.equalToSuperview().inset(45)
        }
        nameLabel.snp.makeConstraints { make in
            make.width.equalToSuperview()
            make.height.equalTo(34)
            make.left.equalTo(30)
            make.bottom.equalTo(titleLabel.snp.top).inset(-10)
        }
        titleLabel.snp.makeConstraints { make in
            make.width.equalToSuperview().inset(30)
            make.height.equalTo(44)
            make.left.equalTo(30)
            make.bottom.equalToSuperview().inset(100)
        }
        progressView.snp.makeConstraints { make in
            make.width.equalTo(120)
            make.left.equalTo(30)
            make.height.equalTo(4)
            make.bottom.equalToSuperview().inset(45)
        }
        bottomView.snp.makeConstraints { make in
            make.width.equalToSuperview()
            make.height.equalTo(250)
            make.bottom.equalToSuperview()
        }
    }
}
