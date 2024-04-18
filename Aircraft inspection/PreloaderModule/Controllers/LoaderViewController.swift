//
//  LoaderViewController.swift
//  Aircraft inspection
//
//  Created by Vasiliy Vygnych on 29.03.2024.
//

import UIKit
import SnapKit

final class LoaderViewController: BaseViewController {
    
    var viewModel: LoaderViewModelProtocol?
    var defaults = UserDefaults.standard
    
//MARK: UIImageView
    private var logoImage: UIImageView = {
       let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleAspectFill
        view.image = UIImage(named: "plane")
        return view
    }()
    private var appNameImage: UIImageView = {
       let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleAspectFit
        view.image = UIImage(named: "appName")
        return view
    }()
    private var ellipseImage: UIImageView = {
       let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleAspectFill
        view.image = UIImage(named: "ellipse")
        return view
    }()
//MARK: UIView
    private var redView: UIView = {
      let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(named: "basikRed")
        view.layer.cornerRadius = 18
        return view
    }()
//MARK: UIProgressView
    private let progressBar: UIProgressView = {
        let view = UIProgressView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.progress = 0.1
        view.tintColor = UIColor(named: "basikRed")
        view.trackTintColor = .gray
        view.layer.cornerRadius = 4
        view.clipsToBounds = true
        return view
    }()
//MARK: UILabel
    private var progressLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.font = .systemFont(ofSize: 16,
                                 weight: .bold)
        label.textAlignment = .center
        label.text = "0%"
        return label
    }()
    private var tileLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.font = .systemFont(ofSize: 15,
                                 weight: .bold)
        label.textAlignment = .center
        label.text = "Add your  aircraft for maintenance"
        return label
    }()
//MARK: viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        addSubview()
        setupeProgressBar()
        setupeConstraint()
    }
//MARK: viewWillAppear
    override func viewWillAppear(_ animated: Bool) {
        settingUpTheView(.loader)
    }
//MARK: addSubview
    private func addSubview() {
        view.addSubview(logoImage)
        view.addSubview(redView)
        redView.addSubview(appNameImage)
        view.addSubview(progressLabel)
        view.addSubview(progressBar)
        view.addSubview(tileLabel)
        view.addSubview(ellipseImage)
    }
//MARK: setupeProgressBar
    private func setupeProgressBar() {
        for x in 0...100 {
            DispatchQueue.main.asyncAfter(deadline: .now() + Double(x)*0.02 ) {
                self.progressBar.setProgress(Float(x)/100,
                                             animated: true)
                let uploader: Float = Float(x) / 100
                self.progressLabel.text = String(format: "%.0f%%",
                                                 uploader * 100)
                if self.progressBar.progress == 1.0 {
                    UIView.animate(withDuration: 0.7) {
                        if self.defaults.bool(forKey: "authorization") == true {
                            self.viewModel?.showTabBarController()
                        } else {
                            self.viewModel?.showFirstController()
                        }
                        self.progressBar.isHidden = true
                        self.progressLabel.isHidden = true
                    }
                }
            }
        }
    }
//MARK: setupeConstraint
    private func setupeConstraint() {
        logoImage.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(145)
            make.centerX.equalToSuperview()
            make.width.equalTo(245.2)
            make.height.equalTo(151.42)
        }
        appNameImage.snp.makeConstraints { make in
            make.top.equalTo(logoImage.snp.bottom).offset(14.99)
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().inset(8)
            make.left.equalTo(8)
            make.height.equalTo(120)
        }
        redView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().inset(43)
            make.left.equalTo(43)
            make.height.equalTo(61)
            make.bottom.equalTo(appNameImage.snp.bottom).inset(2)
        }
        progressBar.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(533)
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().inset(16)
            make.left.equalTo(16)
            make.height.equalTo(8)
        }
        progressLabel.snp.makeConstraints { make in
            make.top.equalTo(progressBar.snp.bottom).offset(5)
            make.centerX.equalToSuperview()
            make.height.equalTo(27)
            make.width.equalTo(40)
        }
        tileLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.height.equalTo(96)
            make.width.equalTo(260)
            make.bottom.equalToSuperview().inset(35)
        }
        ellipseImage.snp.makeConstraints { make in
            make.width.equalToSuperview()
            make.height.equalTo(378)
            make.bottom.equalToSuperview()
        }
    }
}
