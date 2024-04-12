//
//  EditingAirplaneCard.swift
//  Aircraft inspection
//
//  Created by Vasiliy Vygnych on 29.03.2024.
//


import UIKit
import SnapKit
import CoreData

class EditingAirplaneCard: BaseViewController {
    
    weak var delegate: TSViewControllerDelegate?
    var viewModel: TSViewModelProtocol?
    var coreManager: CoreDataManagerProtocol?
    var model: AirplaneList?
    
    
//MARK: UIScrollView
    private lazy var scrollView: UIScrollView = {
       let view = UIScrollView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        return view
    }()
//MARK: nameView
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
        settingUpTheView(.edit)
        navigationController?.navigationBar.isHidden = true
    }
//MARK: addSubview
    private func addSubview() {
        view.addSubview(scrollView)
        scrollView.addSubview(nameView)
        nameView.addSubview(namePlaceholder)
        nameView.addSubview(nameTextField)
        nameTextField.delegate = self
        scrollView.addSubview(modelView)
        modelView.addSubview(modelPlaceholder)
        modelView.addSubview(modelTextField)
        modelTextField.delegate = self
        scrollView.addSubview(SNView)
        SNView.addSubview(SNPlaceholder)
        SNView.addSubview(SNTextField)
        SNTextField.delegate = self
        scrollView.addSubview(LIView)
        LIView.addSubview(LIPlaceholder)
        LIView.addSubview(LITextField)
        LITextField.delegate = self
        scrollView.addSubview(UpIView)
        UpIView.addSubview(UpIPlaceholder)
        UpIView.addSubview(UpITextField)
        UpITextField.delegate = self
        view.addSubview(saveButton)
    }
//MARK: setupTextFieldText
    private func setupTextFieldText(model: AirplaneList?) {
        nameTextField.text = model?.name
        modelTextField.text = model?.model
        SNTextField.text = model?.serialNumber
        let formater = DateFormatter()
        guard let lastIn = model?.lastInsp else { return }
        guard let UpIn = model?.upcomingInsp else { return }
        formater.dateFormat = "dd.MM.yy"
        let lastInsp = formater.string(from: lastIn)
        let UpInsp = formater.string(from: UpIn)
        LITextField.text = lastInsp
        UpITextField.text = UpInsp  
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
//MARK: Model makeConstraints
        modelView.snp.makeConstraints { make in
            make.top.equalTo(nameView.snp.bottom).offset(10)
            make.width.equalToSuperview().inset(29)
            make.left.equalTo(29)
            make.height.equalTo(89)
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
            make.height.equalTo(89)
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
            make.height.equalTo(89)
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
            make.height.equalTo(89)
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
    }
    @objc func save() {
        viewModel?.clickAnimate(view: saveButton)
        editAirplane()
        dismiss(animated: true) {
            self.delegate?.reloadData()
        }
    }
    @objc func willShow(_ notification: Notification) {
        scrollView.contentOffset = CGPoint(x: 0,
                                           y: 60)
    }
    @objc func willHide(_ notification: Notification) {
        scrollView.contentOffset = CGPoint.zero
    }
    @objc func endEditing(_ gestuge: UIGestureRecognizer) {
        view.endEditing(true)
    }
    deinit {
        removeKeyboardNotofocation()
    }
}
//MARK: - extension UITextFieldDelegate
extension EditingAirplaneCard: UITextFieldDelegate {
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
        if textField == modelTextField {
            modelView.layer.borderColor = UIColor(named: "basikRed")?.cgColor
            modelView.layer.borderWidth = 1
            modelTextField.text = newString
            if viewModel?.validateCount(text: newString,
                                        minimumCount: 4) == true {
                modelView.layer.borderColor = UIColor.clear.cgColor
            }
        }
        if textField == SNTextField {
            SNView.layer.borderColor = UIColor(named: "basikRed")?.cgColor
            SNView.layer.borderWidth = 1
            SNTextField.text = newString
            if viewModel?.validateCount(text: newString,
                                        minimumCount: 4) == true {
                SNView.layer.borderColor = UIColor.clear.cgColor
            }
        }
        if textField == LITextField {
            LIView.layer.borderColor = UIColor(named: "basikRed")?.cgColor
            LIView.layer.borderWidth = 1
            let mask = "**.**.**"
            LITextField.text = "".addingMask(value: newString,
                                             mask: mask)
            
            if viewModel?.validateCount(text: newString,
                                        minimumCount: 8) == true {
                LIView.layer.borderColor = UIColor.clear.cgColor
            }
        }
        if textField == UpITextField {
            UpIView.layer.borderColor = UIColor(named: "basikRed")?.cgColor
            UpIView.layer.borderWidth = 1
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
//MARK: - editAirplane
extension EditingAirplaneCard {
    func editAirplane() {
        let formater = DateFormatter()
        formater.dateFormat = "dd.MM.yy"
        let lastInsp = formater.date(from: LITextField.text ?? "")
        let upcomingInsp = formater.date(from: UpITextField.text ?? "")
        formater.dateFormat = "dd.MM.yy"
        guard let id = model?.id else { return }
        coreManager?.editAirplane(with: Int(id),
                                  name: nameTextField.text,
                                  model: modelTextField.text,
                                  serialNumber: SNTextField.text,
                                  lastInsp: lastInsp,
                                  upcomingInsp: upcomingInsp)
    }
}
