//
//  AddingMonotoringCard.swift
//  Aircraft inspection
//
//  Created by Vasiliy Vygnych on 08.04.2024.
//

import UIKit
import SnapKit
import CoreData

class AddingMonotoringCard: BaseViewController {
    
    weak var delegate: MonitoringVCDelegate?
    var viewModel: MonitoringVMProtocol?
    var coreManager: CoreDataManagerProtocol?
    let fetchRequest = NSFetchRequest<MonitoringList>(entityName: "MonitoringList")
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
        weightTextField.delegate = self
        scrollView.addSubview(ETView)
        ETView.addSubview(ETPlaceholder)
        ETView.addSubview(ETTextField)
        ETTextField.delegate = self
        scrollView.addSubview(APView)
        APView.addSubview(APPlaceholder)
        APView.addSubview(APTextField)
        APTextField.delegate = self
        scrollView.addSubview(FCView)
        FCView.addSubview(FCPlaceholder)
        FCView.addSubview(FCTextField)
        FCTextField.delegate = self
        scrollView.addSubview(balanceLabel)
        view.addSubview(goodButton)
        goodButton.addSubview(goodLabel)
        view.addSubview(violatedButton)
        violatedButton.addSubview(violatedLabel)
        scrollView.addSubview(flexSpaceView)
        view.addSubview(saveButton)
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
            make.top.equalTo(70)
            make.width.equalToSuperview().inset(29)
            make.left.equalTo(29)
            make.height.lessThanOrEqualTo(89)
            make.height.greaterThanOrEqualTo(77.5)
            make.bottom.equalTo(weightView.snp.top).inset(-10)
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
            make.height.lessThanOrEqualTo(89)
            make.height.greaterThanOrEqualTo(77.5)
            make.bottom.equalTo(ETView.snp.top).inset(-10)
        }
        weightPlaceholder.snp.makeConstraints { make in
            make.top.equalTo(10)
            make.width.equalTo(50)
            make.left.equalTo(20)
            make.height.equalTo(27)
        }
        weightTextField.snp.makeConstraints { make in
            make.top.equalTo(weightPlaceholder.snp.bottom).offset(5)
            make.width.equalToSuperview().inset(18)
            make.left.equalTo(18)
            make.height.equalTo(27)
        }
//MARK: Engine temperature makeConstraints
        ETView.snp.makeConstraints { make in
            make.top.equalTo(weightView.snp.bottom).offset(10)
            make.width.equalToSuperview().inset(29)
            make.left.equalTo(29)
            make.height.lessThanOrEqualTo(89)
            make.height.greaterThanOrEqualTo(77.5)
            make.bottom.equalTo(APView.snp.top).inset(-10)
        }
        ETPlaceholder.snp.makeConstraints { make in
            make.top.equalTo(10)
            make.width.equalTo(140)
            make.left.equalTo(20)
            make.height.equalTo(27)
        }
        ETTextField.snp.makeConstraints { make in
            make.top.equalTo(ETPlaceholder.snp.bottom).offset(5)
            make.width.equalToSuperview().inset(18)
            make.left.equalTo(18)
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
        APTextField.snp.makeConstraints { make in
            make.top.equalTo(APPlaceholder.snp.bottom).offset(5)
            make.width.equalToSuperview().inset(18)
            make.left.equalTo(18)
            make.height.equalTo(27)
        }
//MARK: Fuel consumption makeConstraints
        FCView.snp.makeConstraints { make in
            make.top.equalTo(APView.snp.bottom).offset(10)
            make.width.equalToSuperview().inset(29)
            make.left.equalTo(29)
            make.height.lessThanOrEqualTo(89)
            make.height.greaterThanOrEqualTo(77.5)
            make.bottom.equalTo(violatedButton.snp.top).inset(-10)
        }
        FCPlaceholder.snp.makeConstraints { make in
            make.top.equalTo(10)
            make.width.equalTo(150)
            make.left.equalTo(20)
            make.height.equalTo(27)
        }
        FCTextField.snp.makeConstraints { make in
            make.top.equalTo(FCPlaceholder.snp.bottom).offset(5)
            make.width.equalToSuperview().inset(18)
            make.left.equalTo(18)
            make.height.equalTo(27)
        }
//MARK: Balance makeConstraints
        balanceLabel.snp.makeConstraints { make in
            make.top.equalTo(FCView.snp.bottom).offset(20)
            make.width.equalTo(70)
            make.height.equalTo(27)
            make.left.equalTo(29)
        }
        violatedButton.snp.makeConstraints { make in
            make.top.equalTo(FCView.snp.bottom).offset(10)
            make.width.equalTo(125)
            make.height.lessThanOrEqualTo(47)
            make.height.greaterThanOrEqualTo(40)
            make.right.equalTo(-29)
            make.bottom.equalTo(flexSpaceView.snp.top).inset(-10)
        }
        violatedLabel.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
            make.width.equalToSuperview()
            make.height.equalTo(20)
        }
        goodButton.snp.makeConstraints { make in
            make.top.equalTo(FCView.snp.bottom).offset(10)
            make.width.equalTo(125)
            make.height.lessThanOrEqualTo(47)
            make.height.greaterThanOrEqualTo(40)
            make.right.equalTo(violatedButton.snp.left).inset(-10)
            make.bottom.equalTo(flexSpaceView.snp.top).inset(-10)
        }
        goodLabel.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
            make.width.equalToSuperview()
            make.height.equalTo(20)
        }
//MARK: flexSpaceView && saveButton makeConstraints
        flexSpaceView.snp.makeConstraints { make in
            make.top.equalTo(violatedButton.snp.bottom).offset(10)
            make.width.equalToSuperview()
            make.bottom.equalTo(saveButton.snp.top).inset(-10)
        }
        saveButton.snp.makeConstraints { make in
            make.top.equalTo(flexSpaceView.snp.bottom).offset(10)
            make.width.equalToSuperview().inset(29)
            make.height.lessThanOrEqualTo(67)
            make.height.greaterThanOrEqualTo(57)
            make.left.equalTo(29)
            make.bottomMargin.equalToSuperview().inset(10)
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
        if sheckValidate() == true {
            addAirplane()
            dismiss(animated: true) {
                self.delegate?.reloadData()
            }
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
//MARK: sheckValidate
    func sheckValidate() -> Bool {
        var validate = Bool()
        if nameTextField.text == "" {
            validate = false
            nameView.layer.borderColor = UIColor(named: "basikRed")?.cgColor
            nameView.layer.borderWidth = 1
        } else {
            validate = true
        }
        if weightTextField.text == "" {
            validate = false
            weightView.layer.borderColor = UIColor(named: "basikRed")?.cgColor
            weightView.layer.borderWidth = 1
        } else {
            validate = true
        }
        if ETTextField.text == "" {
            validate = false
            ETView.layer.borderColor = UIColor(named: "basikRed")?.cgColor
            ETView.layer.borderWidth = 1
        } else {
            validate = true
        }
        if APTextField.text == "" {
            validate = false
            APView.layer.borderColor = UIColor(named: "basikRed")?.cgColor
            APView.layer.borderWidth = 1
        } else {
            validate = true
        }
        if FCTextField.text == "" {
            validate = false
            FCView.layer.borderColor = UIColor(named: "basikRed")?.cgColor
            FCView.layer.borderWidth = 1
        } else {
            validate = true
        }
        return validate
    }
}
//MARK: - extension UITextFieldDelegate
extension AddingMonotoringCard: UITextFieldDelegate {
    func textField(_ textField: UITextField,
                  shouldChangeCharactersIn range: NSRange,
                   replacementString string: String) -> Bool {
        guard let text = textField.text else { return false }
        let newString = (text as NSString).replacingCharacters(in: range,
                                                               with: string)
        if textField == nameTextField {
            nameTextField.text = newString
            nameView.layer.borderColor = UIColor.clear.cgColor
        }
        if textField == weightTextField {
            weightTextField.text = newString
            weightView.layer.borderColor = UIColor.clear.cgColor
        }
        if textField == ETTextField {
            ETTextField.text = newString
            ETView.layer.borderColor = UIColor.clear.cgColor
        }
        if textField == APTextField {
            APTextField.text = newString
            APView.layer.borderColor = UIColor.clear.cgColor
        }
        if textField == FCTextField {
            FCTextField.text = newString
            FCView.layer.borderColor = UIColor.clear.cgColor
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
extension AddingMonotoringCard {
    func addAirplane() {
        guard let context = coreManager?.context,
              let entity = NSEntityDescription.entity(forEntityName: "MonitoringList",
                                                      in: context) else { return }
          let model = MonitoringList(entity: entity,
                                   insertInto: coreManager?.context)
        guard let weight = weightTextField.text,
         let engineTemperature = ETTextField.text,
         let airPressure = APTextField.text,
         let fuelConsumption = FCTextField.text else { return }
        do {
            let count = try context.count(for: fetchRequest)
            let id = Int16(count - 1)
            model.id = id
            model.name = nameTextField.text
            
            model.weight = Int32(weight) ?? 0
            model.engineTemperature = Int32(engineTemperature) ?? 0
            model.airPressure =  Int32(airPressure) ?? 0
            model.fuelConsumption =  Double(fuelConsumption) ?? 0
            model.balance = self.balance
        } catch {
            print(error.localizedDescription)
        }
        coreManager?.delegat.saveContext()
    }
}
