//
//  DetailAnalyticsController.swift
//  Aircraft inspection
//
//  Created by Vasiliy Vygnych on 09.04.2024.
//

import UIKit
import SnapKit
import CoreData

class DetailAnalyticsController: BaseViewController {
    
    weak var delegate: AnalyticsVCDelegate?
    var viewModel: AnalyticsVMProtocol?
    var coreManager: CoreDataManagerProtocol?
    var model: FlightsList?
    
//MARK: Date of verification
    private var dateView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(named: "basikGray")
        view.layer.cornerRadius = 11
        return view
    }()
    private var dateTitleLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.font = .RobotoFlex(ofSize: 20,
                                 weight: ._700)
        label.textAlignment = .left
        return label
    }()
    private var datePlaceholder: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor(named: "white66")
        label.font = .RobotoFlex(ofSize: 15,
                                 weight: ._400)
        label.textAlignment = .left
        label.text = "Date of verification"
        return label
    }()
//MARK: Systems and components
    private var SCView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(named: "basikGray")
        view.layer.cornerRadius = 11
        return view
    }()
    private var SCPlaceholder: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor(named: "white66")
        label.font = .RobotoFlex(ofSize: 15,
                                 weight: ._400)
        label.textAlignment = .left
        label.text = "Systems and components"
        return label
    }()
    private var SCTitleLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .green
        label.font = .RobotoFlex(ofSize: 20,
                                 weight: ._700)
        label.textAlignment = .left
        return label
    }()
//MARK: Electronics and avionis
    private var EAview: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(named: "basikGray")
        view.layer.cornerRadius = 11
        return view
    }()
    private var EAtitleLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.font = .RobotoFlex(ofSize: 20,
                                 weight: ._700)
        label.textAlignment = .left
        return label
    }()
    private var EAplaceholder: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor(named: "white66")
        label.font = .RobotoFlex(ofSize: 14.8,
                                 weight: ._300)
        label.textAlignment = .left
        label.text = "Electronics and avionis"
        return label
    }()
//MARK: Identification and certification
    private var ICView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(named: "basikGray")
        view.layer.cornerRadius = 11
        return view
    }()
    private var ICTitleLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.font = .RobotoFlex(ofSize: 20,
                                 weight: ._700)
        label.textAlignment = .left
        return label
    }()
    private var ICPlaceholder: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor(named: "white66")
        label.font = .RobotoFlex(ofSize: 14.8,
                                 weight: ._300)
        label.textAlignment = .left
        label.text = "Identification and certification"
        return label
    }()
//MARK: Notes
    private var notesView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(named: "basikGray")
        view.layer.cornerRadius = 11
        return view
    }()
    private var notesTitleLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.font = .RobotoFlex(ofSize: 15,
                                 weight: ._500)
        label.textAlignment = .left
        label.numberOfLines = 0
        return label
    }()
    private var notesPlaceholder: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor(named: "white66")
        label.font = .RobotoFlex(ofSize: 14.8,
                                 weight: ._300)
        label.textAlignment = .left
        label.text = "Notes"
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
    private func configure(model: FlightsList?) {
        nameLabel.text = model?.name
        notesTitleLabel.text = model?.notes
        guard let data = model?.reportFrom else { return }
        let formatter = DateFormatter()
        formatter.dateFormat = "d MMM yyyy"
        dateTitleLabel.text = formatter.string(from: data)
        if model?.systAndComp == true {
            SCTitleLabel.text = "Good"
            SCTitleLabel.textColor = UIColor(named: "basikGreen")
        } else {
            SCTitleLabel.text = "Violated"
            SCTitleLabel.textColor = UIColor(named: "matRed")
        }
        if model?.electronicsAvionics == true {
            EAtitleLabel.text = "Good"
            EAtitleLabel.textColor = UIColor(named: "basikGreen")
        } else {
            EAtitleLabel.text = "Violated"
            EAtitleLabel.textColor = UIColor(named: "matRed")
        }
        if model?.identAndCertific == true {
            ICTitleLabel.text = "Good"
            ICTitleLabel.textColor = UIColor(named: "basikGreen")
        } else {
            ICTitleLabel.text = "Violated"
            ICTitleLabel.textColor = UIColor(named: "matRed")
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
        view.addSubview(removeButton)
        view.addSubview(buttonElementImage)
        view.addSubview(nameLabel)
        view.addSubview(dateView)
        dateView.addSubview(datePlaceholder)
        dateView.addSubview(dateTitleLabel)
        view.addSubview(SCView)
        SCView.addSubview(SCPlaceholder)
        SCView.addSubview(SCTitleLabel)
        view.addSubview(EAview)
        EAview.addSubview(EAplaceholder)
        EAview.addSubview(EAtitleLabel)
        view.addSubview(ICView)
        ICView.addSubview(ICPlaceholder)
        ICView.addSubview(ICTitleLabel)
        view.addSubview(notesView)
        notesView.addSubview(notesPlaceholder)
        notesView.addSubview(notesTitleLabel)
        view.addSubview(flexSpaceView)
    }
//MARK: setupeButton
    private func setupeButton() {
        removeButton.addTarget(self,
                               action: #selector(remove),
                               for: .touchUpInside)
    }
    @objc func remove() {
        deleteAnalytics()
    }
//MARK: deleteAnalytics
    func deleteAnalytics() {
        let alert = UIAlertController(title: "Deletion",
                                      message: "Do you really want to delete it?",
                                      preferredStyle: .alert)
        let cancel = UIAlertAction(title: "No",
                                   style: .default)
        let delet = UIAlertAction(title: "Yes",
                                         style: .destructive) { (action) in
            guard let index = self.model?.id else { return }
            self.coreManager?.deleteFlightsList(id: Int(index))
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
        nameLabel.snp.makeConstraints { make in
            make.top.greaterThanOrEqualTo(40)
            make.top.lessThanOrEqualTo(80)
            make.width.equalTo(200)
            make.height.equalTo(32)
            make.centerX.equalToSuperview()
        }
//MARK: Date of verification makeConstraints
        dateView.snp.makeConstraints { make in
            make.top.greaterThanOrEqualTo(nameLabel.snp.bottom).offset(10)
            make.top.lessThanOrEqualTo(nameLabel.snp.bottom).offset(30)
            make.width.equalToSuperview().inset(29)
            make.left.equalTo(29)
            make.height.lessThanOrEqualTo(89)
            make.height.greaterThanOrEqualTo(77.5)
            make.bottom.equalTo(SCView.snp.top).inset(-10)
        }
        datePlaceholder.snp.makeConstraints { make in
            make.top.equalTo(10)
            make.width.equalTo(150)
            make.left.equalTo(20)
            make.height.equalTo(27)
        }
        dateTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(datePlaceholder.snp.bottom).offset(5)
            make.width.greaterThanOrEqualTo(20)
            make.left.equalTo(18)
            make.height.equalTo(27)
        }
//MARK: Systems and components makeConstraints
        SCView.snp.makeConstraints { make in
            make.top.equalTo(dateView.snp.bottom).offset(10)
            make.width.equalToSuperview().inset(29)
            make.left.equalTo(29)
            make.height.lessThanOrEqualTo(89)
            make.height.greaterThanOrEqualTo(77.5)
            make.bottom.equalTo(EAview.snp.top).inset(-10)
        }
        SCPlaceholder.snp.makeConstraints { make in
            make.top.equalTo(10)
            make.width.equalTo(200)
            make.left.equalTo(20)
            make.height.equalTo(27)
        }
        SCTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(SCPlaceholder.snp.bottom).offset(5)
            make.width.equalTo(150)
            make.left.equalTo(18)
            make.height.equalTo(27)
        }
//MARK: Electronics and avionis makeConstraints
        EAview.snp.makeConstraints { make in
            make.top.equalTo(SCView.snp.bottom).offset(10)
            make.width.equalToSuperview().inset(29)
            make.left.equalTo(29)
            make.height.lessThanOrEqualTo(89)
            make.height.greaterThanOrEqualTo(77.5)
            make.bottom.equalTo(ICView.snp.top).inset(-10)
        }
        EAplaceholder.snp.makeConstraints { make in
            make.top.equalTo(10)
            make.width.equalTo(200)
            make.left.equalTo(20)
            make.height.equalTo(27)
        }
        EAtitleLabel.snp.makeConstraints { make in
            make.top.equalTo(EAplaceholder.snp.bottom).offset(5)
            make.width.greaterThanOrEqualTo(20)
            make.left.equalTo(18)
            make.height.equalTo(27)
        }
//MARK: Identification and certification makeConstraints
        ICView.snp.makeConstraints { make in
            make.top.equalTo(EAview.snp.bottom).offset(10)
            make.width.equalToSuperview().inset(29)
            make.left.equalTo(29)
            make.height.lessThanOrEqualTo(89)
            make.height.greaterThanOrEqualTo(77.5)
            make.bottom.equalTo(notesView.snp.top).inset(-10)
        }
        ICPlaceholder.snp.makeConstraints { make in
            make.top.equalTo(10)
            make.width.equalTo(230)
            make.left.equalTo(20)
            make.height.equalTo(27)
        }
        ICTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(ICPlaceholder.snp.bottom).offset(5)
            make.width.greaterThanOrEqualTo(20)
            make.left.equalTo(18)
            make.height.equalTo(27)
        }
//MARK: Notes makeConstraints
        notesView.snp.makeConstraints { make in
            make.top.equalTo(ICView.snp.bottom).offset(10)
            make.width.equalToSuperview().inset(29)
            make.left.equalTo(29)
            make.height.greaterThanOrEqualTo(77.5)
            make.height.lessThanOrEqualTo(280)
            make.bottom.equalTo(flexSpaceView.snp.top).inset(-10)
        }
        notesPlaceholder.snp.makeConstraints { make in
            make.top.equalTo(10)
            make.width.equalTo(150)
            make.left.equalTo(20)
            make.height.equalTo(27)
        }
        notesTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(notesPlaceholder.snp.bottom).offset(5)
            make.width.equalToSuperview().inset(18)
            make.left.equalTo(18)
            make.bottom.equalToSuperview().inset(10)
        }
        flexSpaceView.snp.makeConstraints { make in
            make.top.equalTo(notesView.snp.bottom).offset(10)
            make.width.equalToSuperview()
            make.bottom.equalToSuperview()
        }
//MARK: buttonElementImage makeConstraints
        buttonElementImage.snp.makeConstraints { make in
            make.width.equalTo(302)
            make.height.equalTo(169)
            make.right.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
}
