//
//  DetailMonotoringCard.swift
//  Aircraft inspection
//
//  Created by Vasiliy Vygnych on 08.04.2024.
//

import UIKit
import SnapKit
import CoreData

class DetailMonotoringCard: BaseViewController {
    
    weak var delegate: MonitoringVCDelegate?
    var viewModel: MonitoringVMProtocol?
    var coreManager: CoreDataManagerProtocol?
    var model: MonitoringList?
    
//MARK: Weight
    private var weightView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(named: "basikGray")
        view.layer.cornerRadius = 11
        return view
    }()
    private var weightTitleLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.font = .RobotoFlex(ofSize: 20,
                                 weight: ._700)
        label.textAlignment = .left
        return label
    }()
    private var weightPlaceholder: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor(named: "white66")
        label.font = .RobotoFlex(ofSize: 14.8,
                                 weight: ._300)
        label.textAlignment = .left
        label.text = "Weight"
        return label
    }()
    private var weightUnitLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.font = .RobotoFlex(ofSize: 20,
                                 weight: ._700)
        label.textAlignment = .left
        label.text = "kg"
        return label
    }()
//MARK: Balance
    private var balanceView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(named: "basikGray")
        view.layer.cornerRadius = 11
        return view
    }()
    private var balancePlaceholder: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor(named: "white66")
        label.font = .RobotoFlex(ofSize: 14.8,
                                 weight: ._300)
        label.textAlignment = .left
        label.text = "Balance"
        return label
    }()
    private var balanceTitleLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .green
        label.font = .RobotoFlex(ofSize: 20,
                                 weight: ._700)
        label.textAlignment = .left
        return label
    }()
    private var checkMarkView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 11
        return view
    }()
    private var checkMarkImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleToFill
        image.tintColor = .white
       return image
    }()
//MARK: Engine temperature
    private var ETView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(named: "basikGray")
        view.layer.cornerRadius = 11
        return view
    }()
    private var ETTitleLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.font = .RobotoFlex(ofSize: 20,
                                 weight: ._700)
        label.textAlignment = .left
        return label
    }()
    private var ETPlaceholder: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor(named: "white66")
        label.font = .RobotoFlex(ofSize: 14.8,
                                 weight: ._300)
        label.textAlignment = .left
        label.text = "Engine temperature"
        return label
    }()
    private var ETUnitLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.font = .RobotoFlex(ofSize: 20,
                                 weight: ._700)
        label.textAlignment = .left
        label.text = "kg"
        return label
    }()
//MARK: Air pressure
    private var APView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(named: "basikGray")
        view.layer.cornerRadius = 11
        return view
    }()
    private var APTitleLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.font = .RobotoFlex(ofSize: 20,
                                 weight: ._700)
        label.textAlignment = .left
        return label
    }()
    private var APPlaceholder: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor(named: "white66")
        label.font = .RobotoFlex(ofSize: 14.8,
                                 weight: ._300)
        label.textAlignment = .left
        label.text = "Air pressure"
        return label
    }()
    private var APUnitLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.font = .RobotoFlex(ofSize: 20,
                                 weight: ._700)
        label.textAlignment = .left
        label.text = "GPa"
        return label
    }()
//MARK: Fuel consumption
    private var FCView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(named: "basikGray")
        view.layer.cornerRadius = 11
        return view
    }()
    private var FCTitleLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.font = .RobotoFlex(ofSize: 20,
                                 weight: ._700)
        label.textAlignment = .left
        return label
    }()
    private var FCPlaceholder: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor(named: "white66")
        label.font = .RobotoFlex(ofSize: 14.8,
                                 weight: ._300)
        label.textAlignment = .left
        label.text = "Fuel consumption"
        return label
    }()
    private var FCUnitLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.font = .RobotoFlex(ofSize: 20,
                                 weight: ._700)
        label.textAlignment = .left
        label.text = "g/pass-km"
        return label
    }()
//MARK: UIImageView
    private var buttonElementImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFill
        image.image = UIImage(named: "elements")
       return image
    }()
//MARK: UILabel
    private var titleLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.font = .RobotoFlex(ofSize: 14.8,
                                 weight: ._300)
        label.textAlignment = .left
        label.text = "Plane parameters"
        return label
    }()
    private var nameLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.font = .RobotoFlex(ofSize: 30,
                                 weight: ._900)
        label.textAlignment = .center
        return label
    }()
//MARK: UIButton
    private var editButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setBackgroundImage(UIImage(named: "editButton"),
                                  for: .normal)
        return button
    }()
    private var removeButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setBackgroundImage(UIImage(named: "removeButton"),
                                  for: .normal)
        return button
    }()
//MARK: UIView
    private var flexSpaceView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        return view
    }()
//MARK: viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubview()
        setupeConstraint()
        setupeButton()
        configure(model: model)
    }
//MARK: configure
    private func configure(model: MonitoringList?) {
        nameLabel.text = model?.name
        if model?.balance == true {
            balanceTitleLabel.text = "Good"
            balanceTitleLabel.textColor = UIColor(named: "basikGreen")
            checkMarkView.backgroundColor = UIColor(named: "basikGreen")
            checkMarkImage.image = UIImage(systemName: "checkmark")
        } else {
            balanceTitleLabel.text = "Violated"
            balanceTitleLabel.textColor = UIColor(named: "matRed")
            checkMarkView.backgroundColor = UIColor(named: "matRed")
            checkMarkImage.image = UIImage(systemName: "xmark")
        }
        guard let weight = model?.weight,
         let engineTemperature = model?.engineTemperature,
         let airPressure = model?.airPressure,
         let fuelConsumption = model?.fuelConsumption else { return }
        weightTitleLabel.text = "\(weight)"
        ETTitleLabel.text = "\(engineTemperature)"
        APTitleLabel.text = "\(airPressure)"
        FCTitleLabel.text = "\(fuelConsumption)"
    }
//MARK: viewWillAppear
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        settingUpTheView(.defaults)
        navigationController?.navigationBar.isHidden = true
    }
//MARK: addSubview
    private func addSubview() {
        view.addSubview(editButton)
        view.addSubview(removeButton)
        view.addSubview(buttonElementImage)
        view.addSubview(titleLabel)
        view.addSubview(nameLabel)
        view.addSubview(weightView)
        weightView.addSubview(weightPlaceholder)
        weightView.addSubview(weightTitleLabel)
        weightView.addSubview(weightUnitLabel)
        view.addSubview(balanceView)
        balanceView.addSubview(balancePlaceholder)
        balanceView.addSubview(balanceTitleLabel)
        balanceView.addSubview(checkMarkView)
        checkMarkView.addSubview(checkMarkImage)
        view.addSubview(ETView)
        ETView.addSubview(ETPlaceholder)
        ETView.addSubview(ETTitleLabel)
        ETView.addSubview(ETUnitLabel)
        view.addSubview(APView)
        APView.addSubview(APPlaceholder)
        APView.addSubview(APTitleLabel)
        APView.addSubview(APUnitLabel)
        view.addSubview(FCView)
        FCView.addSubview(FCPlaceholder)
        FCView.addSubview(FCTitleLabel)
        FCView.addSubview(FCUnitLabel)
        
        view.addSubview(flexSpaceView)
    }
//MARK: setupeButton
    private func setupeButton() {
        removeButton.addTarget(self,
                               action: #selector(remove),
                               for: .touchUpInside)
        editButton.addTarget(self,
                               action: #selector(edit),
                               for: .touchUpInside)
    }
    @objc func remove() {
        deleteAirplane()
    }
    @objc func edit() {
        dismiss(animated: true) {
            self.viewModel?.presentEditingMonotoringCardView(model: self.model)
        }
    }
    deinit {
        self.delegate?.reloadData()
    }
//MARK: deleteAirplane
    func deleteAirplane() {
        let alert = UIAlertController(title: "Deletion",
                                      message: "Do you really want to delete it?",
                                      preferredStyle: .alert)
        let cancel = UIAlertAction(title: "No",
                                   style: .default)
        let delet = UIAlertAction(title: "Yes",
                                         style: .destructive) { (action) in
            guard let index = self.model?.id else { return }
            self.coreManager?.deleteMonitoringList(id: Int(index))
            self.dismiss(animated: true) {
                self.delegate?.reloadData()
            }
        }
        alert.addAction(cancel)
        alert.addAction(delet)
        alert.setValue(NSAttributedString(string: alert.title ?? "",
                                          attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 17,
                                                                                                       weight: UIFont.Weight.medium),NSAttributedString.Key.foregroundColor : UIColor.white]), forKey: "attributedTitle")
        alert.setValue(NSAttributedString(string: alert.message ?? "",
                                          attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 13,
                                                                                                       weight: UIFont.Weight.light),NSAttributedString.Key.foregroundColor : UIColor.white]), forKey: "attributedMessage")
        alert.view.subviews.first?.subviews.first?.subviews.first?.backgroundColor = UIColor(named: "alert")
        alert.view.tintColor = .white
        present(alert,
                animated: true)
    }
//MARK: setupeConstraint
    private func setupeConstraint() {
        removeButton.snp.makeConstraints { make in
            make.top.equalTo(25)
            make.width.height.equalTo(24)
            make.right.equalTo(-29)
        }
        editButton.snp.makeConstraints { make in
            make.top.equalTo(25)
            make.width.height.equalTo(24)
            make.right.equalTo(removeButton.snp.left).inset(-20)
        }
        nameLabel.snp.makeConstraints { make in
            make.top.greaterThanOrEqualTo(40)
            make.top.lessThanOrEqualTo(80)
            make.width.equalTo(200)
            make.height.equalTo(32)
            make.centerX.equalToSuperview()
        }
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(5)
            make.width.equalTo(120)
            make.centerX.equalToSuperview()
            make.height.equalTo(22)
        }
//MARK: Weight makeConstraints
        weightView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(30)
            make.width.equalToSuperview().inset(29)
            make.left.equalTo(29)
            make.height.lessThanOrEqualTo(89)
            make.height.greaterThanOrEqualTo(77.5)
            make.bottom.equalTo(balanceView.snp.top).inset(-10)
        }
        weightPlaceholder.snp.makeConstraints { make in
            make.top.equalTo(10)
            make.width.equalTo(50)
            make.left.equalTo(20)
            make.height.equalTo(27)
        }
        weightTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(weightPlaceholder.snp.bottom).offset(5)
            make.width.greaterThanOrEqualTo(20)
            make.left.equalTo(18)
            make.height.equalTo(27)
        }
        weightUnitLabel.snp.makeConstraints { make in
            make.top.equalTo(weightPlaceholder.snp.bottom).offset(5)
            make.width.equalTo(25)
            make.left.equalTo(weightTitleLabel.snp.right).inset(-5)
            make.height.equalTo(27)
        }
//MARK: Balance makeConstraints
        balanceView.snp.makeConstraints { make in
            make.top.equalTo(weightView.snp.bottom).offset(10)
            make.width.equalToSuperview().inset(29)
            make.left.equalTo(29)
            make.height.lessThanOrEqualTo(89)
            make.height.greaterThanOrEqualTo(77.5)
            make.bottom.equalTo(ETView.snp.top).inset(-10)
        }
        balancePlaceholder.snp.makeConstraints { make in
            make.top.equalTo(10)
            make.width.equalTo(57)
            make.left.equalTo(20)
            make.height.equalTo(27)
        }
        balanceTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(balancePlaceholder.snp.bottom).offset(5)
            make.width.equalTo(150)
            make.left.equalTo(18)
            make.height.equalTo(27)
        }
        checkMarkView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.width.height.equalTo(20.8)
            make.right.equalTo(-29)
        }
        checkMarkImage.snp.makeConstraints { make in
            make.centerY.centerX.equalToSuperview()
            make.height.equalTo(15)
            make.width.equalTo(12)
        }
//MARK: Engine temperature makeConstraints
        ETView.snp.makeConstraints { make in
            make.top.equalTo(balanceView.snp.bottom).offset(10)
            make.width.equalToSuperview().inset(29)
            make.left.equalTo(29)
            make.height.lessThanOrEqualTo(89)
            make.height.greaterThanOrEqualTo(77.5)
            make.bottom.equalTo(APView.snp.top).inset(-10)
        }
        ETPlaceholder.snp.makeConstraints { make in
            make.top.equalTo(10)
            make.width.equalTo(150)
            make.left.equalTo(20)
            make.height.equalTo(27)
        }
        ETTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(ETPlaceholder.snp.bottom).offset(5)
            make.width.greaterThanOrEqualTo(20)
            make.left.equalTo(18)
            make.height.equalTo(27)
        }
        ETUnitLabel.snp.makeConstraints { make in
            make.top.equalTo(ETPlaceholder.snp.bottom).offset(5)
            make.width.equalTo(25)
            make.left.equalTo(ETTitleLabel.snp.right).inset(-5)
            make.height.equalTo(27)
        }
//MARK: Air pressure makeConstraints
        APView.snp.makeConstraints { make in
            make.top.equalTo(ETView.snp.bottom).offset(10)
            make.width.equalToSuperview().inset(29)
            make.left.equalTo(29)
            make.height.lessThanOrEqualTo(89)
            make.height.greaterThanOrEqualTo(77.5)
            make.bottom.equalTo(FCView.snp.top).inset(-10)
        }
        APPlaceholder.snp.makeConstraints { make in
            make.top.equalTo(10)
            make.width.equalTo(120)
            make.left.equalTo(20)
            make.height.equalTo(27)
        }
        APTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(APPlaceholder.snp.bottom).offset(5)
            make.width.greaterThanOrEqualTo(20)
            make.left.equalTo(18)
            make.height.equalTo(27)
        }
        APUnitLabel.snp.makeConstraints { make in
            make.top.equalTo(APPlaceholder.snp.bottom).offset(5)
            make.width.equalTo(55)
            make.left.equalTo(APTitleLabel.snp.right).inset(-5)
            make.height.equalTo(27)
        }
//MARK: Fuel consumption makeConstraints
        FCView.snp.makeConstraints { make in
            make.top.equalTo(APView.snp.bottom).offset(10)
            make.width.equalToSuperview().inset(29)
            make.left.equalTo(29)
            make.height.lessThanOrEqualTo(89)
            make.height.greaterThanOrEqualTo(77.5)
            make.bottom.equalTo(flexSpaceView.snp.top).inset(-10)
        }
        FCPlaceholder.snp.makeConstraints { make in
            make.top.equalTo(10)
            make.width.equalTo(150)
            make.left.equalTo(20)
            make.height.equalTo(27)
        }
        FCTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(FCPlaceholder.snp.bottom).offset(5)
            make.width.greaterThanOrEqualTo(20)
            make.left.equalTo(18)
            make.height.equalTo(27)
        }
        FCUnitLabel.snp.makeConstraints { make in
            make.top.equalTo(FCPlaceholder.snp.bottom).offset(5)
            make.width.greaterThanOrEqualTo(65)
            make.left.equalTo(FCTitleLabel.snp.right).inset(-5)
            make.height.equalTo(27)
        }
//MARK: flexSpaceView && buttonElementImage makeConstraints
        flexSpaceView.snp.makeConstraints { make in
            make.top.equalTo(FCView.snp.bottom).offset(10)
            make.width.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        buttonElementImage.snp.makeConstraints { make in
            make.width.equalTo(302)
            make.height.equalTo(169)
            make.right.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
}
