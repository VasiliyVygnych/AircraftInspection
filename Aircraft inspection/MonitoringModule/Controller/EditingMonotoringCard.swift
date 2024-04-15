//
//  EditingMonotoringCard.swift
//  Aircraft inspection
//
//  Created by Vasiliy Vygnych on 08.04.2024.
//

import UIKit
import SnapKit
import CoreData

class EditingMonotoringCard: BaseViewController {
    
    weak var delegate: MonitoringVCDelegate?
    var viewModel: MonitoringVMProtocol?
    var coreManager: CoreDataManagerProtocol?
    var model: MonitoringList?
    var balance = Bool()
    
//MARK: UIScrollView
    private lazy var scrollView: UIScrollView = {
       let view = UIScrollView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        return view
    }()
//MARK: Name
    private var nameView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(named: "basikGray")
        view.layer.cornerRadius = 11
        return view
    }()
    private var nameTextField: UITextField = {
       let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.textColor = .white
        textField.font = .RobotoFlex(ofSize: 20,
                                     weight: ._700)
        return textField
    }()
    private var namePlaceholder: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor(named: "white66")
        label.font = .RobotoFlex(ofSize: 14.8,
                                 weight: ._300)
        label.textAlignment = .left
        label.text = "Name"
        return label
    }()
//MARK: Weight
    private var weightView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(named: "basikGray")
        view.layer.cornerRadius = 11
        return view
    }()
    private var weightTextField: UITextField = {
       let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.textColor = .white
        textField.font = .RobotoFlex(ofSize: 20,
                                     weight: ._700)
        return textField
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
//MARK: Engine temperature
    private var ETView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(named: "basikGray")
        view.layer.cornerRadius = 11
        return view
    }()
    private var ETTextField: UITextField = {
       let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.textColor = .white
        textField.font = .RobotoFlex(ofSize: 20,
                                     weight: ._700)
        return textField
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
    private var APTextField: UITextField = {
       let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.textColor = .white
        textField.font = .RobotoFlex(ofSize: 20,
                                     weight: ._700)
        return textField
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
    private var FCTextField: UITextField = {
       let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.textColor = .white
        textField.font = .RobotoFlex(ofSize: 20,
                                     weight: ._700)
        return textField
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
//MARK: Balance
    private var balanceLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor(named: "white66")
        label.font = .RobotoFlex(ofSize: 14.8,
                                 weight: ._300)
        label.textAlignment = .left
        label.text = "Balance"
        return label
    }()
    private var goodLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.font = .RobotoFlex(ofSize: 20,
                                 weight: ._700)
        label.textAlignment = .center
        label.text = "Good"
        return label
    }()
    private var violatedLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.font = .RobotoFlex(ofSize: 20,
                                 weight: ._700)
        label.textAlignment = .center
        label.text = "Violated"
        return label
    }()
    private var goodButton: UIButton = {
       let view = UIButton()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 11
        view.backgroundColor = UIColor(named: "basikGray")
        return view
    }()
    private var violatedButton: UIButton = {
       let view = UIButton()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 11
        view.backgroundColor = UIColor(named: "basikGray")
        return view
    }()
//MARK: UIButton
    private var saveButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("SAVE",
                        for: .normal)
        button.setTitleColor(UIColor.black,
                             for: .normal)
        button.backgroundColor = .white
        button.layer.cornerRadius = 13
        return button
    }()
//MARK: viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubview()
        setupeConstraint()
        setupeButton()
        setupTextFieldText(model: model)
        registerForKeyboardNotificftion()
        gestureRecognizer.addTarget(self,
                                    action: #selector(endEditing))
        scrollView.addGestureRecognizer(gestureRecognizer)
    }
//MARK: viewWillAppear
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        settingUpTheView(.add)
        navigationController?.navigationBar.isHidden = true
    }
//MARK: addSubview
    private func addSubview() {
        view.addSubview(scrollView)
        scrollView.addSubview(nameView)
        nameView.addSubview(namePlaceholder)
        nameView.addSubview(nameTextField)
        nameTextField.delegate = self
        scrollView.addSubview(weightView)
        weightView.addSubview(weightPlaceholder)
        weightView.addSubview(weightTextField)
        weightView.addSubview(weightUnitLabel)
        weightTextField.delegate = self
        scrollView.addSubview(ETView)
        ETView.addSubview(ETPlaceholder)
        ETView.addSubview(ETTextField)
        ETView.addSubview(ETUnitLabel)
        ETTextField.delegate = self
        scrollView.addSubview(APView)
        APView.addSubview(APPlaceholder)
        APView.addSubview(APTextField)
        APView.addSubview(APUnitLabel)
        APTextField.delegate = self
        scrollView.addSubview(FCView)
        FCView.addSubview(FCPlaceholder)
        FCView.addSubview(FCTextField)
        FCView.addSubview(FCUnitLabel)
        FCTextField.delegate = self
        scrollView.addSubview(balanceLabel)
        view.addSubview(goodButton)
        goodButton.addSubview(goodLabel)
        view.addSubview(violatedButton)
        violatedButton.addSubview(violatedLabel)
        view.addSubview(saveButton)
    }
//MARK: setupTextFieldText
    private func setupTextFieldText(model: MonitoringList?) {
        guard let text = model else { return }
        if model?.balance == true {
            goodButton.backgroundColor = .white
            goodLabel.textColor = .black
        } else {
            violatedButton.backgroundColor = .white
            violatedLabel.textColor = .black
        }
        nameTextField.text = model?.name
        weightTextField.text = String(text.weight)
        ETTextField.text = String(text.engineTemperature)
        APTextField.text = String(text.airPressure)
        FCTextField.text = String(text.fuelConsumption)
    }
//MARK: registerForKeyboardNotificftion
    func registerForKeyboardNotificftion() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(willShow),
                                               name: UIResponder.keyboardWillShowNotification,
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(willHide),
                                               name: UIResponder.keyboardWillHideNotification,
                                               object: nil)
    }
//MARK: removeKeyboardNotofocation
    func removeKeyboardNotofocation() {
        NotificationCenter.default.removeObserver(self,
                                                  name: UIResponder.keyboardWillShowNotification,
                                                  object: nil)
        NotificationCenter.default.removeObserver(self,
                                                  name: UIResponder.keyboardWillHideNotification,
                                                  object: nil)
    }
//MARK: makeConstraint
    private func setupeConstraint() {
        scrollView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.leading.trailing.equalToSuperview()
        }
//MARK: Name makeConstraints
        nameView.snp.makeConstraints { make in
            make.top.equalTo(80)
            make.width.equalToSuperview().inset(29)
            make.left.equalTo(29)
            make.height.equalTo(89)
        }
        namePlaceholder.snp.makeConstraints { make in
            make.top.equalTo(10)
            make.width.equalTo(50)
            make.left.equalTo(20)
            make.height.equalTo(27)
        }
        nameTextField.snp.makeConstraints { make in
            make.top.equalTo(namePlaceholder.snp.bottom).offset(5)
            make.width.equalToSuperview().inset(18)
            make.left.equalTo(18)
            make.height.equalTo(27)
        }
//MARK: Weight makeConstraints
        weightView.snp.makeConstraints { make in
            make.top.equalTo(nameView.snp.bottom).offset(10)
            make.width.equalToSuperview().inset(29)
            make.left.equalTo(29)
            make.height.equalTo(89)
        }
        weightPlaceholder.snp.makeConstraints { make in
            make.top.equalTo(10)
            make.width.equalTo(50)
            make.left.equalTo(20)
            make.height.equalTo(27)
        }
        weightTextField.snp.makeConstraints { make in
            make.top.equalTo(weightPlaceholder.snp.bottom).offset(5)
            make.width.equalToSuperview().inset(20)
            make.left.equalTo(18)
            make.height.equalTo(27)
        }
        weightUnitLabel.snp.makeConstraints { make in
            make.top.equalTo(weightPlaceholder.snp.bottom).offset(5)
            make.width.equalTo(25)
            make.left.equalTo(weightTextField.snp.right).inset(-5)
            make.height.equalTo(27)
        }
//MARK: Engine temperature makeConstraints
        ETView.snp.makeConstraints { make in
            make.top.equalTo(weightView.snp.bottom).offset(10)
            make.width.equalToSuperview().inset(29)
            make.left.equalTo(29)
            make.height.equalTo(89)
        }
        ETPlaceholder.snp.makeConstraints { make in
            make.top.equalTo(10)
            make.width.equalTo(140)
            make.left.equalTo(20)
            make.height.equalTo(27)
        }
        ETTextField.snp.makeConstraints { make in
            make.top.equalTo(ETPlaceholder.snp.bottom).offset(5)
            make.width.greaterThanOrEqualTo(20)
            make.left.equalTo(18)
            make.height.equalTo(27)
        }
        ETUnitLabel.snp.makeConstraints { make in
            make.top.equalTo(ETPlaceholder.snp.bottom).offset(5)
            make.width.equalTo(25)
            make.left.equalTo(ETTextField.snp.right).inset(-5)
            make.height.equalTo(27)
        }
//MARK: Air pressure makeConstraints
        APView.snp.makeConstraints { make in
            make.top.equalTo(ETView.snp.bottom).offset(10)
            make.width.equalToSuperview().inset(29)
            make.left.equalTo(29)
            make.height.equalTo(89)
        }
        APPlaceholder.snp.makeConstraints { make in
            make.top.equalTo(10)
            make.width.equalTo(120)
            make.left.equalTo(20)
            make.height.equalTo(27)
        }
        APTextField.snp.makeConstraints { make in
            make.top.equalTo(APPlaceholder.snp.bottom).offset(5)
            make.width.greaterThanOrEqualTo(20)
            make.left.equalTo(18)
            make.height.equalTo(27)
        }
        APUnitLabel.snp.makeConstraints { make in
            make.top.equalTo(APPlaceholder.snp.bottom).offset(5)
            make.width.equalTo(55)
            make.left.equalTo(APTextField.snp.right).inset(-5)
            make.height.equalTo(27)
        }
//MARK: Fuel consumption makeConstraints
        FCView.snp.makeConstraints { make in
            make.top.equalTo(APView.snp.bottom).offset(10)
            make.width.equalToSuperview().inset(29)
            make.left.equalTo(29)
            make.height.equalTo(89)
        }
        FCPlaceholder.snp.makeConstraints { make in
            make.top.equalTo(10)
            make.width.equalTo(150)
            make.left.equalTo(20)
            make.height.equalTo(27)
        }
        FCTextField.snp.makeConstraints { make in
            make.top.equalTo(FCPlaceholder.snp.bottom).offset(5)
            make.width.greaterThanOrEqualTo(20)
            make.left.equalTo(18)
            make.height.equalTo(27)
        }
        FCUnitLabel.snp.makeConstraints { make in
            make.top.equalTo(FCPlaceholder.snp.bottom).offset(5)
            make.width.greaterThanOrEqualTo(65)
            make.left.equalTo(FCTextField.snp.right).inset(-5)
            make.height.equalTo(27)
        }
//MARK: Balance makeConstraints
        balanceLabel.snp.makeConstraints { make in
            make.top.equalTo(FCView.snp.bottom).offset(25)
            make.width.equalTo(70)
            make.height.equalTo(27)
            make.left.equalTo(29)
        }
        violatedButton.snp.makeConstraints { make in
            make.top.equalTo(FCView.snp.bottom).offset(10)
            make.width.equalTo(125)
            make.height.equalTo(47)
            make.right.equalTo(-29)
        }
        violatedLabel.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
            make.width.equalToSuperview()
            make.height.equalTo(20)
        }
        goodButton.snp.makeConstraints { make in
            make.top.equalTo(FCView.snp.bottom).offset(10)
            make.width.equalTo(125)
            make.height.equalTo(47)
            make.right.equalTo(violatedButton.snp.left).inset(-10)
        }
        goodLabel.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
            make.width.equalToSuperview()
            make.height.equalTo(20)
        }
//MARK: saveButton makeConstraints
        saveButton.snp.makeConstraints { make in
            make.width.equalToSuperview().inset(29)
            make.height.equalTo(67)
            make.left.equalTo(29)
            make.bottom.equalToSuperview().inset(40)
        }
    }
//MARK: setupeButton
    private func setupeButton() {
        saveButton.addTarget(self,
                             action: #selector(save),
                             for: .touchUpInside)
        goodButton.addTarget(self,
                             action: #selector(good),
                             for: .touchUpInside)
        violatedButton.addTarget(self,
                                 action: #selector(violated),
                                 for: .touchUpInside)
    }
    @objc func save(sender: UIButton) {
        viewModel?.clickAnimate(view: saveButton)
        editAirplane()
        dismiss(animated: true) {
            self.delegate?.reloadData()
        }
    }
    @objc func good(sender: UIButton) {
        viewModel?.clickAnimate(view: goodButton)
        balance = true
        if goodButton.backgroundColor == UIColor(named: "basikGray") {
            violatedButton.backgroundColor = UIColor(named: "basikGray")
            goodButton.backgroundColor = .white
            goodLabel.textColor = .black
            violatedLabel.textColor = .white
             } else {
                 goodButton.backgroundColor = UIColor(named: "basikGray")
                 goodLabel.textColor = .white
        }
    }
    @objc func violated(sender: UIButton) {
        viewModel?.clickAnimate(view: violatedButton)
        balance = false
        if violatedButton.backgroundColor == UIColor(named: "basikGray") {
            goodButton.backgroundColor = UIColor(named: "basikGray")
            goodLabel.textColor = .white
            violatedButton.backgroundColor = .white
            violatedLabel.textColor = .black
             } else {
                 violatedButton.backgroundColor = UIColor(named: "basikGray")
                 violatedLabel.textColor = .white
        }
    }
    @objc func willShow(_ notification: Notification) {
        scrollView.contentOffset = CGPoint(x: 0,
                                           y: 60)
        goodButton.isHidden = true
        violatedButton.isHidden = true
    }
    @objc func willHide(_ notification: Notification) {
        scrollView.contentOffset = CGPoint.zero
    }
    @objc func endEditing(_ gestuge: UIGestureRecognizer) {
        view.endEditing(true)
        goodButton.isHidden = false
        violatedButton.isHidden = false
    }
    deinit {
        removeKeyboardNotofocation()
    }
}
//MARK: - extension UITextFieldDelegate
extension EditingMonotoringCard: UITextFieldDelegate {
    func textField(_ textField: UITextField,
                  shouldChangeCharactersIn range: NSRange,
                   replacementString string: String) -> Bool {
        guard let text = textField.text else { return false }
        let newString = (text as NSString).replacingCharacters(in: range,
                                                               with: string)
        if textField == nameTextField {
            nameView.layer.borderColor = UIColor(named: "basikRed")?.cgColor
            nameView.layer.borderWidth = 1
            nameTextField.text = newString
            if viewModel?.validateCount(text: newString,
                                        minimumCount: 4) == true {
                nameView.layer.borderColor = UIColor.clear.cgColor
            }
        }
        if textField == weightTextField {
            weightView.layer.borderColor = UIColor(named: "basikRed")?.cgColor
            weightView.layer.borderWidth = 1
            weightTextField.text = newString
            if viewModel?.validateCount(text: newString,
                                        minimumCount: 2) == true {
                weightView.layer.borderColor = UIColor.clear.cgColor
            }
        }
        if textField == ETTextField {
            ETView.layer.borderColor = UIColor(named: "basikRed")?.cgColor
            ETView.layer.borderWidth = 1
            ETTextField.text = newString
            if viewModel?.validateCount(text: newString,
                                        minimumCount: 2) == true {
                ETView.layer.borderColor = UIColor.clear.cgColor
            }
        }
        if textField == APTextField {
            APView.layer.borderColor = UIColor(named: "basikRed")?.cgColor
            APView.layer.borderWidth = 1
            APTextField.text = newString
            if viewModel?.validateCount(text: newString,
                                        minimumCount: 3) == true {
                APView.layer.borderColor = UIColor.clear.cgColor
            }
        }
        if textField == FCTextField {
            FCView.layer.borderColor = UIColor(named: "basikRed")?.cgColor
            FCView.layer.borderWidth = 1
            FCTextField.text = newString
            if viewModel?.validateCount(text: newString,
                                        minimumCount: 2) == true {
                FCView.layer.borderColor = UIColor.clear.cgColor
            }
        }
       return false
    }
//MARK: textFieldShouldReturn
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        goodButton.isHidden = false
        violatedButton.isHidden = false
        return true
    }
}
//MARK: - addAirplane
extension EditingMonotoringCard {
    func editAirplane() {
        guard let weight = weightTextField.text,
         let engineTemperature = ETTextField.text,
         let airPressure = APTextField.text,
         let fuelConsumption = FCTextField.text else { return }
        guard let id = model?.id else { return }
        coreManager?.editMonitoringList(with: Int(id),
                                        weight: Int32(weight) ?? 0,
                                        name: nameTextField.text,
                                        airPressure: Int32(airPressure) ?? 0,
                                        engineTemperature: Int32(engineTemperature) ?? 0,
                                        fuelConsumption: Double(fuelConsumption) ?? 0,
                                        balance: self.balance)
    }
}


