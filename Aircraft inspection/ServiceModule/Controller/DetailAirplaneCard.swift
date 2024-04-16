//
//  DetailAirplaneCard.swift
//  Aircraft inspection
//
//  Created by Vasiliy Vygnych on 29.03.2024.
//

import UIKit
import SnapKit
import CoreData

class DetailAirplaneCard: BaseViewController {
    
    weak var delegate: TSViewControllerDelegate?
    var viewModel: TSViewModelProtocol?
    var coreManager: CoreDataManagerProtocol?
    var model: AirplaneList?
    
//MARK: Model
    private var modelView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(named: "basikGray")
        view.layer.cornerRadius = 11
        return view
    }()
    private var modelTitleLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.font = .RobotoFlex(ofSize: 20,
                                 weight: ._700)
        label.textAlignment = .left
        return label
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
    private var SNTitleLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.font = .RobotoFlex(ofSize: 20,
                                 weight: ._700)
        label.textAlignment = .left
        return label
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
    private var LITitleLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.font = .RobotoFlex(ofSize: 20,
                                 weight: ._700)
        label.textAlignment = .left
        return label
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
    private var UpITitleLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.font = .RobotoFlex(ofSize: 20,
                                 weight: ._700)
        label.textAlignment = .left
        return label
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
//MARK: UIImageView
    private var buttonElementImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFill
        image.image = UIImage(named: "elements")
       return image
    }()
    private var topElementImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFill
        image.image = UIImage(named: "topElement")
       return image
    }()
//MARK: UILabel
    private var titleLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.font = .RobotoFlex(ofSize: 14,
                                 weight: ._300)
        label.textAlignment = .left
        label.text = "About the plane"
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
    private var modelLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .lightGray
        label.font = .RobotoFlex(ofSize: 14.8,
                                 weight: ._300)
        label.textAlignment = .center
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
//MARK: viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubview()
        setupeConstraint()
        setupeButton()
        nameLabel.text = model?.name
        modelLabel.text = model?.model
        modelTitleLabel.text = model?.model
        SNTitleLabel.text = model?.serialNumber
        setupData(model: model)
    }
//MARK: setupData
    private func setupData(model: AirplaneList?) {
        let formater = DateFormatter()
        guard let lastIn = model?.lastInsp else { return }
        guard let UpIn = model?.upcomingInsp else { return }
        formater.dateFormat = "dd.MM.yy"
        LITitleLabel.text = formater.string(from: lastIn)
        UpITitleLabel.text = formater.string(from: UpIn)
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
        view.addSubview(topElementImage)
        view.addSubview(titleLabel)
        view.addSubview(nameLabel)
        view.addSubview(modelLabel)
        view.addSubview(modelView)
        modelView.addSubview(modelPlaceholder)
        modelView.addSubview(modelTitleLabel)
        view.addSubview(SNView)
        SNView.addSubview(SNPlaceholder)
        SNView.addSubview(SNTitleLabel)
        view.addSubview(LIView)
        LIView.addSubview(LIPlaceholder)
        LIView.addSubview(LITitleLabel)
        view.addSubview(UpIView)
        UpIView.addSubview(UpIPlaceholder)
        UpIView.addSubview(UpITitleLabel)
        
        
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
            self.viewModel?.presentEditingAirplaneCardView(model: self.model)
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
            self.coreManager?.deleteAirplane(id: Int(index))
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
            make.top.equalTo(40)
            make.width.equalTo(200)
            make.height.equalTo(32)
            make.centerX.equalToSuperview()
        }
        modelLabel.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(5)
            make.width.equalTo(200)
            make.height.equalTo(20)
            make.centerX.equalToSuperview()
        }
        topElementImage.snp.makeConstraints { make in
            make.top.equalTo(modelLabel.snp.bottom).offset(30)
            make.width.greaterThanOrEqualTo(271)
            make.width.lessThanOrEqualTo(301)
            make.height.greaterThanOrEqualTo(62.67)
            make.height.lessThanOrEqualTo(92.97)
            make.centerX.equalToSuperview()
        }
        titleLabel.snp.makeConstraints { make in
            make.top.lessThanOrEqualTo(topElementImage.snp.bottom).offset(40)
            make.width.equalTo(120)
            make.left.equalTo(29)
            make.height.equalTo(22)
            make.bottom.equalTo(modelView.snp.top).inset(-10)
        }
//MARK: Model makeConstraints
        modelView.snp.makeConstraints { make in
            make.width.equalToSuperview().inset(29)
            make.left.equalTo(29)
            make.height.greaterThanOrEqualTo(80)
            make.height.lessThanOrEqualTo(89)
            make.bottom.equalTo(SNView.snp.top).inset(-10)
        }
        modelPlaceholder.snp.makeConstraints { make in
            make.top.equalTo(10)
            make.width.equalTo(50)
            make.left.equalTo(20)
            make.height.equalTo(27)
        }
        modelTitleLabel.snp.makeConstraints { make in
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
            make.height.greaterThanOrEqualTo(80)
            make.height.lessThanOrEqualTo(89)
            make.bottom.equalTo(LIView.snp.top).inset(-10)
        }
        SNPlaceholder.snp.makeConstraints { make in
            make.top.equalTo(10)
            make.width.equalTo(120)
            make.left.equalTo(20)
            make.height.equalTo(27)
        }
        SNTitleLabel.snp.makeConstraints { make in
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
            make.height.greaterThanOrEqualTo(80)
            make.height.lessThanOrEqualTo(89)
            make.bottom.equalTo(UpIView.snp.top).inset(-10)
        }
        LIPlaceholder.snp.makeConstraints { make in
            make.top.equalTo(10)
            make.width.equalTo(120)
            make.left.equalTo(20)
            make.height.equalTo(27)
        }
        LITitleLabel.snp.makeConstraints { make in
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
            make.height.greaterThanOrEqualTo(80)
            make.height.lessThanOrEqualTo(89)
        }
        UpIPlaceholder.snp.makeConstraints { make in
            make.top.equalTo(10)
            make.width.equalTo(150)
            make.left.equalTo(20)
            make.height.equalTo(27)
        }
        UpITitleLabel.snp.makeConstraints { make in
            make.top.equalTo(UpIPlaceholder.snp.bottom).offset(5)
            make.width.equalToSuperview().inset(18)
            make.left.equalTo(18)
            make.height.equalTo(27)
        }
//MARK: flexSpaceView && buttonElementImage makeConstraints
        flexSpaceView.snp.makeConstraints { make in
            make.top.equalTo(UpIView.snp.bottom).offset(10)
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
