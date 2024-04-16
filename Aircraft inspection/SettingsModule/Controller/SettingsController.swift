//
//  SettingsController.swift
//  Aircraft inspection
//
//  Created by Vasiliy Vygnych on 10.04.2024.
//

import UIKit
import SnapKit

class SettingsController: BaseViewController {
    
    var viewModel: SettingsViewModelProtocol?

//MARK: Share app
    private var shareButton: UIButton = {
       let view = UIButton()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 11
        view.backgroundColor = UIColor(named: "basikGray")
        return view
    }()
    private var shareLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor(named: "white58")
        label.font = .RobotoFlex(ofSize: 14.8,
                                 weight: ._700)
        label.textAlignment = .center
        label.text = "Share app"
        return label
    }()
    private var shareImageButton: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFill
        image.image = UIImage(named: "shareApp")
        return image
    }()
//MARK: Usage Policy
    private var uPolicyButton: UIButton = {
       let view = UIButton()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 11
        view.backgroundColor = UIColor(named: "basikGray")
        return view
    }()
    private var uPolicyLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor(named: "white58")
        label.font = .RobotoFlex(ofSize: 14.8,
                                 weight: ._700)
        label.textAlignment = .center
        label.text = "Usage Policy"
        return label
    }()
    private var uPolicyImageButton: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFill
        image.image = UIImage(named: "usagePolicy")
        return image
    }()
//MARK: Rate app
    private var rateButton: UIButton = {
       let view = UIButton()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 11
        view.backgroundColor = UIColor(named: "basikGray")
        return view
    }()
    private var rateLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor(named: "white58")
        label.font = .RobotoFlex(ofSize: 14.8,
                                 weight: ._700)
        label.textAlignment = .center
        label.text = "Rate app"
        return label
    }()
    private var rateImageButton: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFill
        image.image = UIImage(named: "rateApp")
        return image
    }()
//MARK: Support
    private var supportButton: UIButton = {
       let view = UIButton()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 11
        view.backgroundColor = UIColor(named: "basikGray")
        return view
    }()
    private var supportLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor(named: "white58")
        label.font = .RobotoFlex(ofSize: 14.8,
                                 weight: ._700)
        label.textAlignment = .center
        label.text = "Support"
        return label
    }()
    private var supportImageButton: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFill
        image.image = UIImage(named: "supportImage")
        return image
    }()
//MARK: UILabel
    private var dateLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.font = .RobotoFlex(ofSize: 14.8,
                                 weight: ._700)
        label.textAlignment = .center
        return label
    }()
//MARK: viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubview()
        setupeConstraint()
        setupeButton()
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm  d MMM yyyy"
        dateLabel.text = formatter.string(from: Date())
    }
//MARK: viewWillAppear
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        navigationController?.navigationBar.isHidden = true
        settingUpTheView(.settings)
    }
//MARK: addSubview
    private func addSubview() {
        view.addSubview(shareButton)
        shareButton.addSubview(shareLabel)
        shareButton.addSubview(shareImageButton)
        view.addSubview(uPolicyButton)
        uPolicyButton.addSubview(uPolicyLabel)
        uPolicyButton.addSubview(uPolicyImageButton)
        view.addSubview(rateButton)
        rateButton.addSubview(rateLabel)
        rateButton.addSubview(rateImageButton)
        view.addSubview(supportButton)
        supportButton.addSubview(supportLabel)
        supportButton.addSubview(supportImageButton)
        view.addSubview(dateLabel)
    }
//MARK: setupeConstraint
    private func setupeConstraint() {
        shareButton.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(70)
            make.width.equalToSuperview().inset(29)
            make.left.equalTo(29)
            make.height.lessThanOrEqualTo(64)
            make.height.greaterThanOrEqualTo(53)
            make.bottom.equalTo(uPolicyButton.snp.top).inset(-10)
        }
        shareLabel.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
            make.width.equalTo(100)
            make.height.equalTo(26)
        }
        shareImageButton.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.width.height.equalTo(24)
            make.left.equalTo(29)
        }
//MARK: Usage Policy makeConstraints
        uPolicyButton.snp.makeConstraints { make in
            make.top.equalTo(shareButton.snp.bottom).offset(10)
            make.width.equalToSuperview().inset(29)
            make.left.equalTo(29)
            make.height.lessThanOrEqualTo(64)
            make.height.greaterThanOrEqualTo(53)
            make.bottom.equalTo(rateButton.snp.top).inset(-10)
        }
        uPolicyLabel.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
            make.width.equalTo(100)
            make.height.equalTo(26)
        }
        uPolicyImageButton.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.width.height.equalTo(24)
            make.left.equalTo(29)
        }
//MARK: Rate app makeConstraints
        rateButton.snp.makeConstraints { make in
            make.top.equalTo(uPolicyButton.snp.bottom).offset(10)
            make.width.equalToSuperview().inset(29)
            make.left.equalTo(29)
            make.height.lessThanOrEqualTo(64)
            make.height.greaterThanOrEqualTo(53)
            make.bottom.equalTo(supportButton.snp.top).inset(-10)
        }
        rateLabel.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
            make.width.equalTo(100)
            make.height.equalTo(26)
        }
        rateImageButton.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.width.height.equalTo(24)
            make.left.equalTo(29)
        }
//MARK: Support makeConstraints
        supportButton.snp.makeConstraints { make in
            make.top.equalTo(rateButton.snp.bottom).offset(10)
            make.width.equalToSuperview().inset(29)
            make.left.equalTo(29)
            make.height.lessThanOrEqualTo(64)
            make.height.greaterThanOrEqualTo(53)
            make.bottom.equalTo(dateLabel.snp.top).inset(-10)
        }
        supportLabel.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
            make.width.equalTo(100)
            make.height.equalTo(26)
        }
        supportImageButton.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.width.height.equalTo(24)
            make.left.equalTo(29)
        }
//MARK: dateLabel makeConstraints
        dateLabel.snp.makeConstraints { make in
            make.top.equalTo(supportButton.snp.bottom).offset(10)
            make.width.equalTo(200)
            make.height.greaterThanOrEqualTo(27)
            make.centerX.equalToSuperview()
            make.bottomMargin.equalToSuperview().inset(10)
        }
    }
//MARK: setupeButton
    private func setupeButton() {
        shareButton.addTarget(self,
                              action: #selector(share),
                              for: .touchUpInside)
        uPolicyButton.addTarget(self,
                              action: #selector(usagePolicy),
                              for: .touchUpInside)
        rateButton.addTarget(self,
                              action: #selector(rateApp),
                              for: .touchUpInside)
        supportButton.addTarget(self,
                              action: #selector(support),
                              for: .touchUpInside)
    }
    @objc func share() {
        viewModel?.clickAnimate(view: shareButton)
        guard let vc = viewModel?.shareApp() else { return }
        present(vc,
                animated: true)
    }
    @objc func usagePolicy() {
        viewModel?.clickAnimate(view: uPolicyButton)
        let controller = UsagePolicyController()
        controller.viewModel = viewModel
        controller.modalPresentationStyle = .fullScreen
        navigationController?.present(controller,
                                      animated: true)
    }
    @objc func rateApp() {
        viewModel?.clickAnimate(view: rateButton)
        viewModel?.rateApp()
    }
    @objc func support() {
        viewModel?.clickAnimate(view: supportButton)
        let controller = SupportViewController()
        controller.viewModel = viewModel
        controller.modalPresentationStyle = .fullScreen
        navigationController?.present(controller,
                                      animated: true)
    }
}
