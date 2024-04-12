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
    
//MARK: UIScrollView
    private lazy var scrollView: UIScrollView = {
       let view = UIScrollView()
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
    
    
    
    
    

    private var toolbar: UIToolbar = {
       let view = UIToolbar()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.sizeToFit()
        view.layer.cornerRadius = 11
        return view
    }()
    private lazy var toolbarTextView: UITextView = {
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
//MARK: viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubview()
        setupeConstraint()
        setupeButton()
        setupeDateView()
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
    }
//MARK: viewWillAppear
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        settingUpTheView(.defaults)
        navigationController?.navigationBar.isHidden = true
    }
//MARK: addSubview
    private func addSubview() {
        view.addSubview(scrollView)
        view.addSubview(nameLabel)
        view.addSubview(dateVertificationLabel)
        view.addSubview(dateView)
        dateView.addSubview(dateTextField)
        view.addSubview(separatorView)
        view.addSubview(SCLabel)
        view.addSubview(SCgoodButton)
        SCgoodButton.addSubview(SCgoodLabel)
        view.addSubview(SCviolatedButton)
        SCviolatedButton.addSubview(SCviolatedLabel)
        view.addSubview(EALabel)
        view.addSubview(EAgoodButton)
        EAgoodButton.addSubview(EAgoodLabel)
        view.addSubview(EAviolatedButton)
        EAviolatedButton.addSubview(EAviolatedLabel)
        view.addSubview(ICLabel)
        view.addSubview(ICgoodButton)
        ICgoodButton.addSubview(ICgoodLabel)
        view.addSubview(ICviolatedButton)
        ICviolatedButton.addSubview(ICviolatedLabel)
        scrollView.addSubview(notesView)
        notesView.addSubview(notesTextView)
        notesTextView.addSubview(notesLabel)
        notesTextView.delegate = self
    
        view.addSubview(toolbar)
        toolbar.addSubview(toolbarTextView)
        notesTextView.inputAccessoryView = toolbar
        toolbar.addSubview(toolbarTextView)
        toolbarTextView.delegate = self
//        toolbar.isHidden = true
        
        
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
    }
//MARK: setupeConstraint
    private func setupeConstraint() {
        scrollView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.leading.trailing.equalToSuperview()
        }
//MARK: Name makeConstraints
        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(70)
            make.width.equalTo(200)
            make.height.equalTo(32)
            make.centerX.equalToSuperview()
        }
        dateVertificationLabel.snp.makeConstraints { make in
            make.top.equalTo(155)
            make.width.equalTo(200)
            make.height.equalTo(27)
        }
        dateView.snp.makeConstraints { make in
            make.top.equalTo(150)
            make.width.equalTo(130) 
            make.height.equalTo(47)
            make.right.equalTo(-29)
        }
        dateTextField.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
            make.width.equalToSuperview().inset(10)
            make.left.equalTo(10)
            make.height.equalTo(20)
        }
        separatorView.snp.makeConstraints { make in
            make.top.equalTo(dateView.snp.bottom).offset(30)
            make.width.equalToSuperview().inset(29)
            make.height.equalTo(2)
            make.left.equalTo(29)
        }
//MARK: Systems and components makeConstraints
        SCLabel.snp.makeConstraints { make in
            make.top.equalTo(separatorView.snp.bottom).offset(20)
            make.width.equalTo(200)
            make.height.equalTo(27)
            make.left.equalTo(29)
        }
        SCviolatedButton.snp.makeConstraints { make in
            make.top.equalTo(SCLabel.snp.bottom).offset(15)
            make.width.equalTo(125)
            make.height.equalTo(47)
            make.left.equalTo(separatorView.snp.centerX).offset(10)
        }
        SCviolatedLabel.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
            make.width.equalToSuperview()
            make.height.equalTo(20)
        }
        SCgoodButton.snp.makeConstraints { make in
            make.top.equalTo(SCLabel.snp.bottom).offset(15)
            make.width.equalTo(125)
            make.height.equalTo(47)
            make.right.equalTo(separatorView.snp.centerX).offset(-10)
        }
        SCgoodLabel.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
            make.width.equalToSuperview()
            make.height.equalTo(20)
        }
//MARK: Electronics and avionics makeConstraints
        EALabel.snp.makeConstraints { make in
            make.top.equalTo(SCgoodButton.snp.bottom).offset(20)
            make.width.equalTo(200)
            make.height.equalTo(27)
            make.left.equalTo(29)
        }
        EAviolatedButton.snp.makeConstraints { make in
            make.top.equalTo(EALabel.snp.bottom).offset(15)
            make.width.equalTo(125)
            make.height.equalTo(47)
            make.left.equalTo(separatorView.snp.centerX).offset(10)
        }
        EAviolatedLabel.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
            make.width.equalToSuperview()
            make.height.equalTo(20)
        }
        EAgoodButton.snp.makeConstraints { make in
            make.top.equalTo(EALabel.snp.bottom).offset(15)
            make.width.equalTo(125)
            make.height.equalTo(47)
            make.right.equalTo(separatorView.snp.centerX).offset(-10)
        }
        EAgoodLabel.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
            make.width.equalToSuperview()
            make.height.equalTo(20)
        }
//MARK: Identification and certification makeConstraints
        ICLabel.snp.makeConstraints { make in
            make.top.equalTo(EAgoodButton.snp.bottom).offset(20)
            make.width.equalTo(200)
            make.height.equalTo(27)
            make.left.equalTo(29)
        }
        ICviolatedButton.snp.makeConstraints { make in
            make.top.equalTo(ICLabel.snp.bottom).offset(15)
            make.width.equalTo(125)
            make.height.equalTo(47)
            make.left.equalTo(separatorView.snp.centerX).offset(10)
        }
        ICviolatedLabel.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
            make.width.equalToSuperview()
            make.height.equalTo(20)
        }
        ICgoodButton.snp.makeConstraints { make in
            make.top.equalTo(ICLabel.snp.bottom).offset(15)
            make.width.equalTo(125)
            make.height.equalTo(47)
            make.right.equalTo(separatorView.snp.centerX).offset(-10)
        }
        ICgoodLabel.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
            make.width.equalToSuperview()
            make.height.equalTo(20)
        }
//MARK: Notes makeConstraints
        notesView.snp.makeConstraints { make in
            make.width.equalToSuperview().inset(29)
            make.height.lessThanOrEqualTo(160)
            make.left.equalTo(29)
            make.bottom.equalTo(addButton.snp.top).inset(-20)
        }
        notesTextView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(10)
            make.width.equalToSuperview().inset(29)
            make.height.greaterThanOrEqualTo(38)
            make.left.equalTo(29)
            make.bottom.equalToSuperview().inset(10)
        }
        notesLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.width.equalTo(50)
            make.left.equalTo(5)
            make.height.equalTo(20)
        }
        
        toolbar.snp.makeConstraints { make in
            make.height.equalTo(160)
        }
        toolbarTextView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(5)
        }
//MARK: addButton makeConstraints
        addButton.snp.makeConstraints { make in
            make.width.equalToSuperview().inset(29)
            make.height.equalTo(67)
            make.left.equalTo(29)
            make.bottom.equalToSuperview().inset(40)
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
        toolbar.isHidden = false
        toolbarTextView.text = textView.text
        notesTextView.text = textView.text
//        if notesTextView.isHidden == true {
//            toolbar.isHidden = false
//        }
        if textView.text == "" {
            notesLabel.isHidden = false
        } else {
            notesLabel.isHidden = true
        }
    }
    override func touchesBegan(_ touches: Set<UITouch>,
                               with event: UIEvent?) {
        toolbarTextView.resignFirstResponder()
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
