//
//  AddingAirplaneCard.swift
//  Aircraft inspection
//
//  Created by Vasiliy Vygnych on 29.03.2024.
//

import UIKit
import SnapKit
import CoreData

class AddingAirplaneCard: BaseViewController {
    
    weak var delegate: TSViewControllerDelegate?
    var viewModel: TSViewModelProtocol?
    var coreManager: CoreDataManagerProtocol?
    let fetchRequest = NSFetchRequest<AirplaneList>(entityName: "AirplaneList")
    
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
//MARK: Model
    private var modelView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(named: "basikGray")
        view.layer.cornerRadius = 11
        return view
    }()
    private var modelTextField: UITextField = {
       let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.textColor = .white
        textField.font = .RobotoFlex(ofSize: 20,
                                 weight: ._700)
        return textField
    }()
    private var modelPlaceholder: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor(named: "white66")
        label.font = .RobotoFlex(ofSize: 14.8,
                                 weight: ._300)
        label.textAlignment = .left
        label.text = "Model"
        return label
    }()
//MARK: Serial number
    private var SNView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(named: "basikGray")
        view.layer.cornerRadius = 11
        return view
    }()
    private var SNTextField: UITextField = {
       let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.textColor = .white
        textField.font = .RobotoFlex(ofSize: 20,
                                 weight: ._700)
        return textField
    }()
    private var SNPlaceholder: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor(named: "white66")
        label.font = .RobotoFlex(ofSize: 14.8,
                                 weight: ._300)
        label.textAlignment = .left
        label.text = "Serial number"
        return label
    }()
//MARK: Last inspection
    private var LIView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(named: "basikGray")
        view.layer.cornerRadius = 11
        return view
    }()
    private var LITextField: UITextField = {
       let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.textColor = .white
        textField.keyboardType = .numberPad
        textField.font = .RobotoFlex(ofSize: 20,
                                 weight: ._700)
        return textField
    }()
    private var LIPlaceholder: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor(named: "white66")
        label.font = .RobotoFlex(ofSize: 14.8,
                                 weight: ._300)
        label.textAlignment = .left
        label.text = "Last inspection"
        return label
    }()
//MARK: Upcoming inspection
    private var UpIView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(named: "basikGray")
        view.layer.cornerRadius = 11
        return view
    }()
    private var UpITextField: UITextField = {
       let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.textColor = .white
        textField.keyboardType = .numberPad
        textField.font = .RobotoFlex(ofSize: 20,
                                 weight: ._700)
        return textField
    }()
    private var UpIPlaceholder: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor(named: "white66")
        label.font = .RobotoFlex(ofSize: 14.8,
                                 weight: ._300)
        label.textAlignment = .left
        label.text = "Upcoming inspection"
        return label
    }()
//MARK: UIView
    private var flexSpaceView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
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
        registerForKeyboardNotificftion()
        gestureRecognizer.addTarget(self,
                                    action: #selector(endEditing))
        view.addGestureRecognizer(gestureRecognizer)
    }
//MARK: viewWillAppear
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        settingUpTheView(.add)
        navigationController?.navigationBar.isHidden = true
    }
//MARK: addSubview
    private func addSubview() {
//        view.addSubview(scrollView)
        view.addSubview(nameView)
        nameView.addSubview(namePlaceholder)
        nameView.addSubview(nameTextField)
        nameTextField.delegate = self
        view.addSubview(modelView)
        modelView.addSubview(modelPlaceholder)
        modelView.addSubview(modelTextField)
        modelTextField.delegate = self
        view.addSubview(SNView)
        SNView.addSubview(SNPlaceholder)
        SNView.addSubview(SNTextField)
        SNTextField.delegate = self
        view.addSubview(LIView)
        LIView.addSubview(LIPlaceholder)
        LIView.addSubview(LITextField)
        LITextField.delegate = self
        view.addSubview(UpIView)
        UpIView.addSubview(UpIPlaceholder)
        UpIView.addSubview(UpITextField)
        UpITextField.delegate = self
        view.addSubview(flexSpaceView)
        view.addSubview(saveButton)
    }
//MARK: registerForKeyboardNotificftion
    func registerForKeyboardNotificftion() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(willShow),
                                               name: UIResponder.keyboardWillChangeFrameNotification,
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(willHide),
                                               name: UIResponder.keyboardWillHideNotification,
                                               object: nil)
    }
//MARK: removeKeyboardNotofocation
    func removeKeyboardNotofocation() {
        NotificationCenter.default.removeObserver(self,
                                                  name: UIResponder.keyboardWillChangeFrameNotification,
                                                  object: nil)
        NotificationCenter.default.removeObserver(self,
                                                  name: UIResponder.keyboardWillHideNotification,
                                                  object: nil)
    }
    private func setupeConstraint() {
//MARK: Name makeConstraints
        nameView.snp.makeConstraints { make in
            make.top.equalTo(80)
            make.width.equalToSuperview().inset(29)
            make.left.equalTo(29)
            make.height.lessThanOrEqualTo(89)
            make.height.greaterThanOrEqualTo(83)
            make.bottom.equalTo(modelView.snp.top).inset(-10)
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
//MARK: Model makeConstraints
        modelView.snp.makeConstraints { make in
            make.top.equalTo(nameView.snp.bottom).offset(10)
            make.width.equalToSuperview().inset(29)
            make.left.equalTo(29)
            make.height.lessThanOrEqualTo(89)
            make.height.greaterThanOrEqualTo(83)
            make.bottom.equalTo(SNView.snp.top).inset(-10)
        }
        modelPlaceholder.snp.makeConstraints { make in
            make.top.equalTo(10)
            make.width.equalTo(50)
            make.left.equalTo(20)
            make.height.equalTo(27)
        }
        modelTextField.snp.makeConstraints { make in
            make.top.equalTo(modelPlaceholder.snp.bottom).offset(5)
            make.width.equalToSuperview().inset(18)
            make.left.equalTo(18)
            make.height.equalTo(27)
        }
//MARK: Serial number makeConstraints
        SNView.snp.makeConstraints { make in
            make.top.equalTo(modelView.snp.bottom).offset(10)
            make.width.equalToSuperview().inset(29)
            make.left.equalTo(29)
            make.height.lessThanOrEqualTo(89)
            make.height.greaterThanOrEqualTo(83)
            make.bottom.equalTo(LIView.snp.top).inset(-10)
        }
        SNPlaceholder.snp.makeConstraints { make in
            make.top.equalTo(10)
            make.width.equalTo(120)
            make.left.equalTo(20)
            make.height.equalTo(27)
        }
        SNTextField.snp.makeConstraints { make in
            make.top.equalTo(SNPlaceholder.snp.bottom).offset(5)
            make.width.equalToSuperview().inset(18)
            make.left.equalTo(18)
            make.height.equalTo(27)
        }
//MARK: Last inspection makeConstraints
        LIView.snp.makeConstraints { make in
            make.top.equalTo(SNView.snp.bottom).offset(10)
            make.width.equalToSuperview().inset(29)
            make.left.equalTo(29)
            make.height.lessThanOrEqualTo(89)
            make.height.greaterThanOrEqualTo(83)
            make.bottom.equalTo(UpIView.snp.top).inset(-10)
        }
        LIPlaceholder.snp.makeConstraints { make in
            make.top.equalTo(10)
            make.width.equalTo(120)
            make.left.equalTo(20)
            make.height.equalTo(27)
        }
        LITextField.snp.makeConstraints { make in
            make.top.equalTo(LIPlaceholder.snp.bottom).offset(5)
            make.width.equalToSuperview().inset(18)
            make.left.equalTo(18)
            make.height.equalTo(27)
        }
//MARK: Upcoming inspection makeConstraints
        UpIView.snp.makeConstraints { make in
            make.top.equalTo(LIView.snp.bottom).offset(10)
            make.width.equalToSuperview().inset(29)
            make.left.equalTo(29)
            make.height.lessThanOrEqualTo(89)
            make.height.greaterThanOrEqualTo(83)
            make.bottom.equalTo(flexSpaceView.snp.top).inset(-10)
        }
        UpIPlaceholder.snp.makeConstraints { make in
            make.top.equalTo(10)
            make.width.equalTo(150)
            make.left.equalTo(20)
            make.height.equalTo(27)
        }
        UpITextField.snp.makeConstraints { make in
            make.top.equalTo(UpIPlaceholder.snp.bottom).offset(5)
            make.width.equalToSuperview().inset(18)
            make.left.equalTo(18)
            make.height.equalTo(27)
        }
        flexSpaceView.snp.makeConstraints { make in
            make.top.equalTo(UpIView.snp.bottom).offset(10)
            make.width.equalToSuperview()
            make.bottom.equalTo(saveButton.snp.top).inset(-10)
        }
//MARK: saveButton makeConstraints
        saveButton.snp.makeConstraints { make in
            make.top.equalTo(flexSpaceView.snp.bottom).offset(10)
            make.width.equalToSuperview().inset(29)
            make.height.lessThanOrEqualTo(67)
            make.height.greaterThanOrEqualTo(57)
            make.left.equalTo(29)
            make.bottomMargin.equalToSuperview().inset(20)
        }
    }
//MARK: setupeButton
    private func setupeButton() {
        saveButton.addTarget(self,
                             action: #selector(save),
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
    @objc func willShow(_ notification: Notification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            if UpITextField.isFirstResponder {
                self.view.frame.origin.y = -keyboardSize.height
            }
            if LITextField.isFirstResponder {
                self.view.frame.origin.y = -keyboardSize.height 
            }
        }
    }
    @objc func willHide(_ notification: Notification) {
        self.view.frame.origin.y = 0
    }
    @objc func endEditing(_ gestuge: UIGestureRecognizer) {
        view.endEditing(true)
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
        if modelTextField.text == "" {
            validate = false
            modelView.layer.borderColor = UIColor(named: "basikRed")?.cgColor
            modelView.layer.borderWidth = 1
        } else {
            validate = true
        }
        if SNTextField.text == "" {
            validate = false
            SNView.layer.borderColor = UIColor(named: "basikRed")?.cgColor
            SNView.layer.borderWidth = 1
        } else {
            validate = true
        }
        if LITextField.text == "" {
            validate = false
            LIView.layer.borderColor = UIColor(named: "basikRed")?.cgColor
            LIView.layer.borderWidth = 1
        } else {
            validate = true
        }
        if UpITextField.text == "" {
            validate = false
            UpIView.layer.borderColor = UIColor(named: "basikRed")?.cgColor
            UpIView.layer.borderWidth = 1
        } else {
            validate = true
        }
        return validate
    }
}
//MARK: - extension UITextFieldDelegate
extension AddingAirplaneCard: UITextFieldDelegate {
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
        if textField == modelTextField {
            modelTextField.text = newString
            modelView.layer.borderColor = UIColor.clear.cgColor
        }
        if textField == SNTextField {
            SNTextField.text = newString
            SNView.layer.borderColor = UIColor.clear.cgColor
        }
        if textField == LITextField {
            let mask = "**.**.**"
            LITextField.text = "".addingMask(value: newString,
                                             mask: mask)
            
            if viewModel?.validateCount(text: newString,
                                        minimumCount: 8) == true {
                LIView.layer.borderColor = UIColor.clear.cgColor
            }
        }
        if textField == UpITextField {
            let mask = "**.**.**"
            UpITextField.text = "".addingMask(value: newString,
                                              mask: mask)
            if viewModel?.validateCount(text: newString,
                                        minimumCount: 8) == true {
                UpIView.layer.borderColor = UIColor.clear.cgColor
            }
        }
       return false
        
        
    }
//MARK: textFieldShouldReturn
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
//MARK: - addAirplane
extension AddingAirplaneCard {
    func addAirplane() {
        guard let context = coreManager?.context,
              let entity = NSEntityDescription.entity(forEntityName: "AirplaneList",
                                                      in: context) else { return }
          let model = AirplaneList(entity: entity,
                                   insertInto: coreManager?.context)
        do {
            let count = try context.count(for: fetchRequest)
            let id = Int16(count - 1)
            model.id = id
            model.name = nameTextField.text
            model.model = modelTextField.text
            model.serialNumber = SNTextField.text
            let formater = DateFormatter()
            formater.dateFormat = "dd.MM.yy"
            let lastInsp = formater.date(from: LITextField.text ?? "")
            let upcomingInsp = formater.date(from: UpITextField.text ?? "")
            formater.dateFormat = "dd.MM.yy"
            model.lastInsp = lastInsp
            model.upcomingInsp = upcomingInsp
        } catch {
            print(error.localizedDescription)
        }
        coreManager?.delegat.saveContext()
    }
}
