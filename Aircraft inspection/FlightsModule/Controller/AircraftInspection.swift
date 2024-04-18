//
//  AircraftInspection.swift
//  Aircraft inspection
//
//  Created by Vasiliy Vygnych on 09.04.2024.
//

import UIKit
import SnapKit
import CoreData
import Combine

class AircraftInspection: BaseViewController {
    
    weak var delegate: FlightsVCDelegate?
    var viewModel: FlightsVMProtocol?
    var coreManager: CoreDataManagerProtocol?
    var model: FlightsList?
    private var systemsAndComponents = Bool()
    private var electronicsAndAvionics = Bool()
    private var identificationAndcertification = Bool()
    private var cancelable: Set<AnyCancellable> = []
    
    @Published var SCButton = Bool()
    @Published var EAButton = Bool()
    @Published var ICButton = Bool()
    @Published var date = Bool()
  
    var isSelectSC: AnyPublisher<Bool, Never> {
        $SCButton
            .map { $0.isSelect() }
            .eraseToAnyPublisher()
    }
    var isSelectEA: AnyPublisher<Bool, Never> {
        $EAButton
            .map { $0.isSelect() }
            .eraseToAnyPublisher()
    }
    var isSelectIC: AnyPublisher<Bool, Never> {
        $ICButton
            .map { $0.isSelect() }
            .eraseToAnyPublisher()
    }
    var isSelectDate: AnyPublisher<Bool, Never> {
        $date
            .map { $0.isSelect() }
            .eraseToAnyPublisher()
    }
    var isButtonEnable: AnyPublisher<Bool, Never> {
        Publishers.CombineLatest4(isSelectSC,
                                  isSelectEA,
                                  isSelectDate,
                                  isSelectIC)
            .map { $3 }
            .eraseToAnyPublisher()
    }

//MARK: UILabel
    private var topConteinerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        return view
    }()
    private var SCConteinerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        return view
    }()
    private var EAConteinerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        return view
    }()
    private var ICConteinerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        return view
    }()
//MARK: UILabel
    private var nameLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.font = .RobotoFlex(ofSize: 30,
                                 weight: ._900)
        label.textAlignment = .center
        return label
    }()
//MARK: Date of vertification
    private var dateVertificationLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor(named: "white66")
        label.font = .RobotoFlex(ofSize: 14.8,
                                 weight: ._400)
        label.textAlignment = .center
        label.text = "Date of vertification"
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
        textField.font = .RobotoFlex(ofSize: 12.22,
                                     weight: ._300)
        return textField
    }()
    private var dateView: UIView = {
       let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 11
        view.backgroundColor = UIColor(named: "basikGray")
        return view
    }()
    private var separatorView: UIView = {
       let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(named: "gray25")
        return view
    }()
//MARK: Systems and components
    private var SCLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor(named: "white66")
        label.font = .RobotoFlex(ofSize: 14.8,
                                 weight: ._300)
        label.textAlignment = .left
        label.text = "Systems and components"
        return label
    }()
    private var SCgoodLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.font = .RobotoFlex(ofSize: 15,
                                 weight: ._500)
        label.textAlignment = .center
        label.text = "Good"
        return label
    }()
    private var SCviolatedLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.font = .RobotoFlex(ofSize: 16,
                                 weight: ._500)
        label.textAlignment = .center
        label.text = "Violated"
        return label
    }()
    private var SCgoodButton: UIButton = {
       let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 11
        button.backgroundColor = UIColor(named: "basikGray")
        button.tag = 0
        return button
    }()
    private var SCviolatedButton: UIButton = {
       let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 11
        button.backgroundColor = UIColor(named: "basikGray")
        button.tag = 1
        return button
    }()
//MARK: Electronics and avionics
    private var EALabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor(named: "white66")
        label.font = .RobotoFlex(ofSize: 14.8,
                                 weight: ._300)
        label.textAlignment = .left
        label.text = "Electronics and avionics"
        return label
    }()
    private var EAgoodLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.font = .RobotoFlex(ofSize: 16,
                                 weight: ._500)
        label.textAlignment = .center
        label.text = "Good"
        return label
    }()
    private var EAviolatedLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.font = .RobotoFlex(ofSize: 16,
                                 weight: ._500)
        label.textAlignment = .center
        label.text = "Violated"
        return label
    }()
    private var EAgoodButton: UIButton = {
       let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 11
        button.backgroundColor = UIColor(named: "basikGray")
        button.tag = 2
        return button
    }()
    private var EAviolatedButton: UIButton = {
       let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 11
        button.backgroundColor = UIColor(named: "basikGray")
        button.tag = 3
        return button
    }()
//MARK: Identification and certification
    private var ICLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor(named: "white66")
        label.font = .RobotoFlex(ofSize: 14.8,
                                 weight: ._300)
        label.textAlignment = .left
        label.text = "Identification and certification"
        return label
    }()
    private var ICgoodLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.font = .RobotoFlex(ofSize: 16,
                                 weight: ._500)
        label.textAlignment = .center
        label.text = "Good"
        return label
    }()
    private var ICviolatedLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.font = .RobotoFlex(ofSize: 16,
                                 weight: ._500)
        label.textAlignment = .center
        label.text = "Violated"
        return label
    }()
    private var ICgoodButton: UIButton = {
       let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 11
        button.backgroundColor = UIColor(named: "basikGray")
        button.tag = 4
        return button
    }()
    private var ICviolatedButton: UIButton = {
       let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 11
        button.backgroundColor = UIColor(named: "basikGray")
        button.tag = 5
        return button
    }()
//MARK: Notes
    private var notesView: UIView = {
       let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(named: "basikGray")
        view.layer.cornerRadius = 11
        return view
    }()
    private lazy var notesTextView: UITextView = {
        let view = UITextView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textColor = .white
        view.backgroundColor = UIColor(named: "basikGray")
        view.layer.cornerRadius = 11
        view.font = .RobotoFlex(ofSize: 14.8,
                                weight: ._500)
        view.isScrollEnabled = false
        view.scrollsToTop = false
        return view
    }()
    private var notesLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .RobotoFlex(ofSize: 14.8,
                                 weight: ._300)
        label.textAlignment = .left
        label.textColor = UIColor(named: "white66")
        label.text = "Notes"
        return label
    }()
//MARK: addButton
    private var addButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .white
        button.layer.cornerRadius = 13
        button.setTitleShadowColor(.white,
                                   for: .disabled)
        return button
    }()
    private var buttonTitle: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .RobotoFlex(ofSize: 16,
                                 weight: ._500)
        label.textAlignment = .center
        label.textColor = .black
        label.text = "ADD"
        return label
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
        setupeDateView()
        registerForKeyboardNotificftion()
        nameLabel.text = model?.name
        isButtonEnable
            .assign(to: \.isEnabled,
                    on: addButton)
            .store(in: &cancelable)
        addButton.configurationUpdateHandler = { button in
            switch button.isEnabled {
            case false:
                button.backgroundColor = UIColor(named: "isEnabled")
            default:
                button.backgroundColor = .white
            }
        }
        configure(model: model)
    }
//MARK: viewWillAppear
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        settingUpTheView(.defaults)
        navigationController?.navigationBar.isHidden = true
    }
//MARK: configure
    private func configure(model: FlightsList?) {
        guard let data = model?.reportFrom else { return }
        let formatter = DateFormatter()
        formatter.dateFormat = "d MMM yyyy"
        dateTextField.text = formatter.string(from: data)
        if model?.notes?.isEmpty == false {
            notesLabel.isHidden = true
            notesTextView.text = model?.notes
        }
    }
//MARK: addSubview
    private func addSubview() {
        view.addSubview(topConteinerView)
        topConteinerView.addSubview(nameLabel)
        topConteinerView.addSubview(dateVertificationLabel)
        topConteinerView.addSubview(dateView)
        dateView.addSubview(dateTextField)
        topConteinerView.addSubview(separatorView)
        view.addSubview(SCConteinerView)
        SCConteinerView.addSubview(SCLabel)
        SCConteinerView.addSubview(SCgoodButton)
        SCgoodButton.addSubview(SCgoodLabel)
        SCConteinerView.addSubview(SCviolatedButton)
        SCviolatedButton.addSubview(SCviolatedLabel)
        view.addSubview(EAConteinerView)
        EAConteinerView.addSubview(EALabel)
        EAConteinerView.addSubview(EAgoodButton)
        EAgoodButton.addSubview(EAgoodLabel)
        EAConteinerView.addSubview(EAviolatedButton)
        EAviolatedButton.addSubview(EAviolatedLabel)
        view.addSubview(ICConteinerView)
        ICConteinerView.addSubview(ICLabel)
        ICConteinerView.addSubview(ICgoodButton)
        ICgoodButton.addSubview(ICgoodLabel)
        ICConteinerView.addSubview(ICviolatedButton)
        ICviolatedButton.addSubview(ICviolatedLabel)
        view.addSubview(flexSpaceView)
        view.addSubview(notesView)
        notesView.addSubview(notesTextView)
        notesTextView.addSubview(notesLabel)
        notesTextView.delegate = self
        view.addSubview(addButton)
        addButton.addSubview(buttonTitle)
    }
//MARK: setupeButton
    private func setupeDateView() {
        guard let data = model?.checkBefore else { return }
        let formatter = DateFormatter()
        formatter.dateFormat = "d MMM yyyy"
        dateTextField.text = formatter.string(from: data)
        dateTextField.inputView = datePicker
        gestureRecognizer.addTarget(self,
                                    action: #selector(done))
        view.addGestureRecognizer(gestureRecognizer)
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
//MARK: setupeButton
    private func setupeButton() {
        SCgoodButton.addTarget(self,
                               action: #selector(SC),
                               for: .touchUpInside)
        SCviolatedButton.addTarget(self,
                               action: #selector(SC),
                               for: .touchUpInside)
        EAgoodButton.addTarget(self,
                               action: #selector(EA),
                               for: .touchUpInside)
        EAviolatedButton.addTarget(self,
                               action: #selector(EA),
                               for: .touchUpInside)
        ICgoodButton.addTarget(self,
                               action: #selector(IC),
                               for: .touchUpInside)
        ICviolatedButton.addTarget(self,
                               action: #selector(IC),
                               for: .touchUpInside)
        addButton.addTarget(self,
                             action: #selector(add),
                             for: .touchUpInside)
    }
    @objc func SC(sender: UIButton) {
        switch sender.tag {
        case 0:
            SCButton = true
            systemsAndComponents = true
            viewModel?.didSelectButton(selectButton: SCgoodButton,
                                       button: SCviolatedButton,
                                       label: SCviolatedLabel,
                                       selectLabel: SCgoodLabel)
        case 1:
            SCButton = true
            systemsAndComponents = false
            viewModel?.didSelectButton(selectButton: SCviolatedButton,
                                       button: SCgoodButton,
                                       label: SCgoodLabel,
                                       selectLabel: SCviolatedLabel)
        default:
            break
        }
    }
    @objc func EA(sender: UIButton) {
        switch sender.tag {
        case 2:
            EAButton = true
            electronicsAndAvionics = true
            viewModel?.didSelectButton(selectButton: EAgoodButton,
                                       button: EAviolatedButton,
                                       label: EAviolatedLabel,
                                       selectLabel: EAgoodLabel)
        case 3:
            EAButton = true
            electronicsAndAvionics = false
            viewModel?.didSelectButton(selectButton: EAviolatedButton,
                                       button: EAgoodButton,
                                       label: EAgoodLabel,
                                       selectLabel: EAviolatedLabel)
        default:
            break
        }
    }
    @objc func IC(sender: UIButton) {
        switch sender.tag {
        case 4:
            ICButton = true
            identificationAndcertification = true
            viewModel?.didSelectButton(selectButton: ICgoodButton,
                                       button: ICviolatedButton,
                                       label: ICviolatedLabel,
                                       selectLabel: ICgoodLabel)
        case 5:
            ICButton = true
            identificationAndcertification = false
            viewModel?.didSelectButton(selectButton: ICviolatedButton,
                                       button: ICgoodButton,
                                       label: ICgoodLabel,
                                       selectLabel: ICviolatedLabel)
        default:
            break
        }
    }
    @objc func add(sender: UIButton) {
        viewModel?.clickAnimate(view: addButton)
        addInspection()
        dismiss(animated: true) {
            self.delegate?.reloadData()
        }
    }
    @objc func done() {
        date = true
        let formatter = DateFormatter()
        formatter.dateFormat = "d MMM yyyy"
        dateTextField.text = formatter.string(from: datePicker.date)
        view.endEditing(true)
        notesTextView.resignFirstResponder()
    }
    @objc func willShow(_ notification: Notification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
               if notesTextView.isFirstResponder {
                   self.view.frame.origin.y = -keyboardSize.height
               }
           }
    }
    @objc func willHide(_ notification: Notification) {
        self.view.frame.origin.y = 0
    }
    deinit {
        removeKeyboardNotofocation()
    }
//MARK: setupeConstraint
    private func setupeConstraint() {
//MARK: Name makeConstraints
        topConteinerView.snp.makeConstraints { make in
            make.top.greaterThanOrEqualTo(50)
            make.top.lessThanOrEqualTo(70)
            make.width.equalToSuperview()
            make.height.greaterThanOrEqualTo(100)
            make.height.lessThanOrEqualTo(110)
            make.bottom.equalTo(SCConteinerView.snp.top).inset(-10)
        }
        nameLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.width.equalTo(200)
            make.height.equalTo(32)
            make.centerX.equalToSuperview()
        }
        dateVertificationLabel.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(10)
            make.width.equalTo(200)
            make.height.equalTo(27)
        }
        dateView.snp.makeConstraints { make in
            make.top.equalTo(topConteinerView.snp.top).offset(39)
            make.width.equalTo(130)
            make.right.equalTo(-29)
            make.bottom.equalTo(topConteinerView.snp.bottom).inset(25)
        }
        dateTextField.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
            make.width.equalToSuperview().inset(10)
            make.left.equalTo(10)
            make.height.equalTo(20)
        }
        separatorView.snp.makeConstraints { make in
            make.top.equalTo(dateView.snp.bottom).offset(20)
            make.width.equalToSuperview().inset(29)
            make.height.equalTo(2)
            make.left.equalTo(29)
        }
//MARK: Systems and components makeConstraints
        SCConteinerView.snp.makeConstraints { make in
            make.top.equalTo(topConteinerView.snp.bottom).offset(10)
            make.width.equalToSuperview()
            make.height.equalTo(90)
            make.bottom.equalTo(EAConteinerView.snp.top).inset(-10)
        }
        SCLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.width.equalTo(200)
            make.height.equalTo(27)
            make.left.equalTo(29)
        }
        SCviolatedButton.snp.makeConstraints { make in
            make.top.equalTo(SCConteinerView.snp.top).offset(37)
            make.width.equalTo(125)
            make.left.equalTo(SCConteinerView.snp.centerX).offset(10)
            make.bottom.equalTo(SCConteinerView.snp.bottom).inset(5)
        }
        SCviolatedLabel.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
            make.width.equalToSuperview()
            make.height.equalTo(20)
        }
        SCgoodButton.snp.makeConstraints { make in
            make.top.equalTo(SCConteinerView.snp.top).offset(37)
            make.width.equalTo(125)
            make.right.equalTo(SCConteinerView.snp.centerX).offset(-10)
            make.bottom.equalTo(SCConteinerView.snp.bottom).inset(5)
        }
        SCgoodLabel.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
            make.width.equalToSuperview()
            make.height.equalTo(20)
        }
//MARK: Electronics and avionics makeConstraints
        EAConteinerView.snp.makeConstraints { make in
            make.top.equalTo(SCConteinerView.snp.bottom).offset(10)
            make.width.equalToSuperview()
            make.height.equalTo(90)
            make.bottom.equalTo(ICConteinerView.snp.top).inset(-10)
        }
        EALabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.width.equalTo(200)
            make.height.equalTo(27)
            make.left.equalTo(29)
        }
        EAviolatedButton.snp.makeConstraints { make in
            make.top.equalTo(EAConteinerView.snp.top).offset(37)
            make.width.equalTo(125)
            make.left.equalTo(EAConteinerView.snp.centerX).offset(10)
            make.bottom.equalTo(EAConteinerView.snp.bottom).inset(5)
        }
        EAviolatedLabel.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
            make.width.equalToSuperview()
            make.height.equalTo(20)
        }
        EAgoodButton.snp.makeConstraints { make in
            make.top.equalTo(EAConteinerView.snp.top).offset(37)
            make.width.equalTo(125)
            make.right.equalTo(EAConteinerView.snp.centerX).offset(-10)
            make.bottom.equalTo(EAConteinerView.snp.bottom).inset(5)
        }
        EAgoodLabel.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
            make.width.equalToSuperview()
            make.height.equalTo(20)
        }
//MARK: Identification and certification makeConstraints
        ICConteinerView.snp.makeConstraints { make in
            make.top.equalTo(EAConteinerView.snp.bottom).offset(10)
            make.width.equalToSuperview()
            make.height.equalTo(90)
            make.bottom.equalTo(flexSpaceView.snp.top).inset(-10)
        }
        ICLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.width.equalTo(200)
            make.height.equalTo(27)
            make.left.equalTo(29)
        }
        ICviolatedButton.snp.makeConstraints { make in make.top.equalTo(ICConteinerView.snp.top).offset(37)
            make.width.equalTo(125)
            make.left.equalTo(ICConteinerView.snp.centerX).offset(10)
            make.bottom.equalTo(ICConteinerView.snp.bottom).inset(5)
        }
        ICviolatedLabel.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
            make.width.equalToSuperview()
            make.height.equalTo(20)
        }
        ICgoodButton.snp.makeConstraints { make in
            make.top.equalTo(ICConteinerView.snp.top).offset(37)
            make.width.equalTo(125)
            make.right.equalTo(ICConteinerView.snp.centerX).offset(-10)
            make.bottom.equalTo(ICConteinerView.snp.bottom).inset(5)
        }
        ICgoodLabel.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
            make.width.equalToSuperview()
            make.height.equalTo(20)
        }
        flexSpaceView.snp.makeConstraints { make in
            make.top.equalTo(ICConteinerView.snp.bottom).offset(10)
            make.width.equalToSuperview()
        }
//MARK: Notes makeConstraints
        notesView.snp.makeConstraints { make in
            make.top.equalTo(flexSpaceView.snp.bottom).offset(10)
            make.width.equalToSuperview().inset(29)
            make.height.greaterThanOrEqualTo(39)
            make.height.lessThanOrEqualTo(160)
            make.left.equalTo(29)
            make.bottom.equalTo(addButton.snp.top).inset(-10)
        }
        notesTextView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(10)
            make.width.equalToSuperview().inset(29)
            make.height.greaterThanOrEqualTo(38)
            make.left.equalTo(29)
            make.bottom.equalToSuperview().inset(10)
        }
        notesLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(5)
            make.width.equalTo(50)
            make.left.equalTo(5)
            make.height.equalTo(20)
        }
//MARK: addButton makeConstraints
        addButton.snp.makeConstraints { make in
            make.top.equalTo(notesView.snp.bottom).offset(10)
            make.width.equalToSuperview().inset(29)
            make.height.greaterThanOrEqualTo(47)
            make.height.lessThanOrEqualTo(67)
            make.left.equalTo(29)
            make.bottomMargin.equalToSuperview().inset(40)
        }
        buttonTitle.snp.makeConstraints { make in
            make.centerY.centerX.equalToSuperview()
            make.width.equalTo(50)
            make.height.equalTo(20)
        }
    }
}
//MARK: - extension UITextViewDelegate
extension AircraftInspection: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        notesTextView.text = textView.text
        if textView.text == "" {
            notesLabel.isHidden = false
        } else {
            notesLabel.isHidden = true
        }
  
    }
    override func touchesBegan(_ touches: Set<UITouch>,
                               with event: UIEvent?) {
        notesTextView.resignFirstResponder()
    }
}
//MARK: addInspection
extension AircraftInspection {
    func addInspection() {
        guard let id = model?.id else { return }
        coreManager?.aircraftInspection(with: Int(id),
                                        date: datePicker.date,
                                        SC: systemsAndComponents,
                                        EA: electronicsAndAvionics,
                                        IC: identificationAndcertification,
                                        notes: notesTextView.text)
    }
}
