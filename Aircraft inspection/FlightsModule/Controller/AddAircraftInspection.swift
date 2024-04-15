//
//  AddAircraftInspection.swift
//  Aircraft inspection
//
//  Created by Vasiliy Vygnych on 09.04.2024.
//

import UIKit
import SnapKit
import CoreData

class AddAircraftInspection: BaseViewController {
    
    weak var delegate: FlightsVCDelegate?
    var viewModel: FlightsVMProtocol?
    var coreManager: CoreDataManagerProtocol?
    let fetchRequest = NSFetchRequest<FlightsList>(entityName: "FlightsList")
    
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
                                 weight: ._400)
        label.textAlignment = .left
        label.text = "Name"
        return label
    }()
//MARK: UIButton
    private var addButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("ADD",
                        for: .normal)
        button.setTitleColor(UIColor.black,
                             for: .normal)
        button.backgroundColor = .white
        button.layer.cornerRadius = 13
        return button
    }()
//MARK: Date inspection
    private var checkLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor(named: "white66")
        label.font = .RobotoFlex(ofSize: 14.8,
                                 weight: ._400)
        label.textAlignment = .left
        label.text = "Check before"
        return label
    }()
    private var datePicker: UIDatePicker = {
       let view = UIDatePicker()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.tintColor = .white
        view.datePickerMode = .date
        view.preferredDatePickerStyle = .wheels
        view.backgroundColor = UIColor(named: "darkGrayColor")
        view.setValue(UIColor.white,
                            forKeyPath: "textColor")
        return view
    }()
    private var dateTextField: UITextField = {
       let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.textColor = .white
        textField.textAlignment = .center
        textField.tintColor = .clear
        return textField
    }()
    private var dateView: UIView = {
       let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 11
        view.backgroundColor = UIColor(named: "basikGray")
        return view
    }()
//MARK: viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubview()
        setupeConstraint()
        setupeButton()
        setupeDateView()
        
    }
//MARK: viewWillAppear
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        settingUpTheView(.add)
        navigationController?.navigationBar.isHidden = true
    }
//MARK: addSubview
    private func addSubview() {
        view.addSubview(nameView)
        nameView.addSubview(namePlaceholder)
        nameView.addSubview(nameTextField)
        nameTextField.delegate = self
        view.addSubview(checkLabel)
        view.addSubview(dateView)
        dateView.addSubview(dateTextField)
        view.addSubview(addButton)
    }
//MARK: setupeDateView
    private func setupeDateView() {
        dateTextField.inputView = datePicker
        dateTextField.text = "date"
        gestureRecognizer.addTarget(self,
                                    action: #selector(done))
        view.addGestureRecognizer(gestureRecognizer)
    }
    @objc func done() {
        let formatter = DateFormatter()
        formatter.dateFormat = "d MMM yyyy"
        dateTextField.text = formatter.string(from: datePicker.date)
        view.endEditing(true)
    }
//MARK: makeConstraint
    private func setupeConstraint() {
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
//MARK: Date inspection makeConstraints
        checkLabel.snp.makeConstraints { make in
            make.top.equalTo(nameView.snp.bottom).offset(20)
            make.width.equalTo(110)
            make.height.equalTo(27)
            make.left.equalTo(29)
        }
        dateView.snp.makeConstraints { make in
            make.top.equalTo(nameView.snp.bottom).offset(10)
            make.width.equalTo(130)
            make.height.equalTo(39.7)
            make.right.equalTo(-29)
        }
        dateTextField.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
            make.width.equalToSuperview().inset(10)
            make.left.equalTo(10)
            make.height.equalTo(20)
        }
//MARK: addButton makeConstraints
        addButton.snp.makeConstraints { make in
            make.width.equalToSuperview().inset(29)
            make.height.equalTo(67)
            make.left.equalTo(29)
            make.bottom.equalToSuperview().inset(40)
        }
    }
//MARK: setupeButton
    private func setupeButton() {
        addButton.addTarget(self,
                             action: #selector(add),
                             for: .touchUpInside)

    }
    @objc func add(sender: UIButton) {
        viewModel?.clickAnimate(view: addButton)
        if sheckValidate() == true {
            addAirplane()
            dismiss(animated: true) {
                self.delegate?.reloadData()
            }
        }
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
        return validate
    }
}
//MARK: - extension UITextFieldDelegate
extension AddAircraftInspection: UITextFieldDelegate {
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
       return false
    }
//MARK: textFieldShouldReturn
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
//MARK: - addAirplane
extension AddAircraftInspection {
    func addAirplane() {
        guard let context = coreManager?.context,
              let entity = NSEntityDescription.entity(forEntityName: "FlightsList",
                                                      in: context) else { return }
          let model = FlightsList(entity: entity,
                                   insertInto: coreManager?.context)
        do {
            let count = try context.count(for: fetchRequest)
            let id = Int16(count - 1)
            model.id = id
            model.name = nameTextField.text
            model.checkBefore = datePicker.date
        } catch {
            print(error.localizedDescription)
        }
        coreManager?.delegat.saveContext()
    }
}
