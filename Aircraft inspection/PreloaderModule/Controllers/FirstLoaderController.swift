//
//  FirstLoaderController.swift
//  Aircraft inspection
//
//  Created by Vasiliy Vygnych on 29.03.2024.
//

import UIKit
import SnapKit

final class FirstLoaderController: BaseViewController {
    
    var viewModel: LoaderViewModelProtocol?
    
//MARK: UIImageView
    private var onboardingImageView: UIImageView = {
       let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleAspectFill
        view.image = UIImage(named: "firstOnboarding")
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
        view.image = UIImage(named: "progressView1")
        return view
    }()
    private var ellipseImage: UIImageView = {
       let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleAspectFill
        view.image = UIImage(named: "ellipse")
        return view
    }()
    private var nextImageView: UIImageView = {
       let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleAspectFill
        view.image = UIImage(named: "arrow-right")
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
        label.text = "Aircraft"
        return label
    }()
    private var titleLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .lightGray
        label.font = .systemFont(ofSize: 17,
                                 weight: .light)
        label.textAlignment = .left
        label.text = "Add your aircraft for maintenance"
        return label
    }()
    private var numberLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.font = .systemFont(ofSize: 20,
                                 weight: .bold)
        label.textAlignment = .center
        label.text = "1"
        label.clipsToBounds = true
        label.layer.cornerRadius = 20
        label.backgroundColor = UIColor(named: "basikRed")
        
        return label
    }()
//MARK: UIButton
    private var nextButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .white
        button.layer.cornerRadius = 16
        return button
    }()
//MARK: viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        DispatchQueue.main.async {
            self.view.addSubview(self.ellipseImage)
            self.view.addSubview(self.onboardingImageView)
            self.view.addSubview(self.bottomView)
            self.view.addSubview(self.nextButton)
            self.nextButton.addSubview(self.nextImageView)
            self.bottomView.addSubview(self.nameLabel)
            self.bottomView.addSubview(self.titleLabel)
            self.bottomView.addSubview(self.progressView)
            self.bottomView.addSubview(self.numberLabel)
            self.setupeConstraint()
            self.setupeGesture()
            self.setupeButton()
        }
    }
//MARK: viewWillAppear
    override func viewWillAppear(_ animated: Bool) {
        settingUpTheView(.preloader)
        navigationController?.navigationBar.isHidden = true
    }
//MARK: setupeGesture
    private func setupeGesture() {
        view.addGestureRecognizer(gestureRecognizer)
        view.addGestureRecognizer(swipeGesture)
        swipeGesture.addTarget(self,
                               action: #selector(nextView))
        swipeGesture.direction = .left
    }
//MARK: setupeButton
    private func setupeButton() {
        nextButton.addTarget(self,
                             action: #selector(nextView),
                             for: .touchUpInside)
    }
    @objc func nextView() {
        viewModel?.showSecondController()
    }
//MARK: setupeConstraint
    private func setupeConstraint() {
        onboardingImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(102)
            make.width.equalTo(323)
            make.centerX.equalToSuperview()
            make.height.equalTo(660)
        }
        ellipseImage.snp.makeConstraints { make in
            make.width.equalToSuperview()
            make.height.equalTo(378)
            make.bottom.equalToSuperview().inset(200)
        }
        numberLabel.snp.makeConstraints { make in
            make.width.height.equalTo(47)
            make.right.equalTo(-30)
            make.bottom.equalTo(progressView.snp.bottom)
        }
        nameLabel.snp.makeConstraints { make in
            make.width.equalToSuperview()
            make.height.equalTo(34)
            make.left.equalTo(30)
            make.bottom.equalTo(titleLabel.snp.top).inset(-10)
        }
        titleLabel.snp.makeConstraints { make in
            make.width.equalToSuperview()
            make.height.equalTo(34)
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
        nextButton.snp.makeConstraints { make in
            make.centerY.equalTo(onboardingImageView.snp.centerY)
            make.width.height.equalTo(32)
            make.right.equalTo(onboardingImageView.snp.right).inset(-12)
            
        }
        nextImageView.snp.makeConstraints { make in
            make.width.height.equalTo(18.96)
            make.centerX.centerY.equalToSuperview()
        }
    }
}
