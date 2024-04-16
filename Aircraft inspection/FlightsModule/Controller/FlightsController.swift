//
//  FlightsController.swift
//  Aircraft inspection
//
//  Created by Vasiliy Vygnych on 30.03.2024.
//

import UIKit
import SnapKit
import CoreData

class FlightsController: BaseViewController {
    
    var viewModel: FlightsVMProtocol?
    var coreManager: CoreDataManagerProtocol?
    
    private var dataSource: UICollectionViewDiffableDataSource<Sections,
                                                               FlightsList>?
    lazy var sortDescriptor = NSSortDescriptor(key: "id",
                                               ascending: false)
    let fetchRequest = NSFetchRequest<FlightsList>(entityName: "FlightsList")
    
//MARK: UIView
    private var conteinerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        return view
    }()
//MARK: UIImageView
    private var buttonImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFill
        image.image = UIImage(named: "plus")
       return image
    }()
    private var topImageView: UIImageView = {
       let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleAspectFill
        view.image = UIImage(named: "flightsView")
        return view
    }()
    private var imageОfЕheLeftCloud: UIImageView = {
       let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFit
        image.image = UIImage(named: "leftCloud")
        return image
    }()
    private var imageОfЕheRightCloud: UIImageView = {
       let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFit
        image.image = UIImage(named: "rightCloud")
        return image
    }()
//MARK: UILabel
    private var topLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = .RobotoFlex(ofSize: 24,
                                 weight: ._900)
        label.textAlignment = .center
        label.text = "Flights"
        return label
    }()
    private var topSubtitleLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor(named: "black46")
        label.font = .RobotoFlex(ofSize: 15,
                                 weight: ._400)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.text = "Fill out nearest flights to check the aircraft"
        return label
    }()
    private var titleLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.font = .RobotoFlex(ofSize: 15,
                                 weight: ._400)
        label.textAlignment = .left
        label.text = "Nearest flights"
        return label
    }()
    private var subTitleLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor(named: "white66")
        label.font = .RobotoFlex(ofSize: 15,
                                 weight: ._400)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.text = "Add nearest flights"
        return label
    }()
//MARK: UIButton
    private var addButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = UIColor(named: "basikRed")
        button.layer.cornerRadius = 31
        return button
    }()
    private var settingsButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setBackgroundImage(UIImage(named: "settings"),
                                  for: .normal)
        button.layer.cornerRadius = 31
        return button
    }()
//MARK: - collectionView & FlowLayout
    private lazy var layout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 15
        layout.sectionInset = .init(top: 10,
                                    left: 10,
                                    bottom: 10,
                                    right: 10)
        return layout
    }()
    lazy var collectionView: UICollectionView = {
       let collectionView = UICollectionView(frame: .zero,
                                             collectionViewLayout: self.layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.contentMode = .scaleAspectFit
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = .clear
        return collectionView
   }()
//MARK: viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel?.setMainController(controller: self)
        addSubview()
        setupecollectionView()
        setupeConstraint()
        setupeButton()
        configureDataSourse()
    }
//MARK: viewWillAppear
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        setupeFetchRequest()
        navigationController?.navigationBar.isHidden = true
        settingUpTheView(.flights)
    }
//MARK: setupeFetchRequest
    private func setupeFetchRequest() {
        fetchRequest.sortDescriptors = [sortDescriptor]
        do {
            guard let data = try coreManager?.context.fetch(fetchRequest) else { return }
            createSnapsShot(model: data)
        } catch {
            print(error.localizedDescription)
        }
        self.collectionView.reloadData()
    }
//MARK: setupecollectionView
    private func setupecollectionView() {
        collectionView.delegate = self
        collectionView.register(InspectionCollectionCell.self,
                                forCellWithReuseIdentifier: "cell")
    }
//MARK: addSubview
    private func addSubview() {
        view.addSubview(conteinerView)
        conteinerView.addSubview(topLabel)
        conteinerView.addSubview(topSubtitleLabel)
        conteinerView.addSubview(imageОfЕheLeftCloud)
        conteinerView.addSubview(imageОfЕheRightCloud)
        conteinerView.addSubview(topImageView)
        view.addSubview(addButton)
        view.addSubview(titleLabel)
        view.addSubview(collectionView)
        addButton.addSubview(buttonImage)
        conteinerView.addSubview(settingsButton)
        view.addSubview(subTitleLabel)
        titleLabel.isHidden = true
    }
//MARK: setupeButton
    private func setupeButton() {
        addButton.addTarget(self,
                            action: #selector(addPlain),
                            for: .touchUpInside)
        settingsButton.addTarget(self,
                                 action: #selector(settings),
                                 for: .touchUpInside)
    }
    @objc func addPlain() {
        viewModel?.clickAnimate(view: addButton)
        viewModel?.presentAddAircraftInspectionView()
    }
    @objc func settings() {
        viewModel?.presentSettingsController()
    }
//MARK: setupeConstraint
    private func setupeConstraint() {
        topLabel.snp.makeConstraints { make in
            make.top.greaterThanOrEqualTo(66)
            make.top.lessThanOrEqualTo(86)
            make.centerX.equalToSuperview()
            make.height.lessThanOrEqualTo(27)
            make.width.equalTo(130)
        }
        topSubtitleLabel.snp.makeConstraints { make in
            make.top.equalTo(topLabel.snp.bottom).offset(10)
            make.centerX.equalToSuperview()
            make.height.lessThanOrEqualTo(40)
            make.width.equalTo(240)
        }
        settingsButton.snp.makeConstraints { make in
            make.top.equalTo(topLabel.snp.top)
            make.right.equalTo(-20)
            make.width.height.equalTo(24)
        }
        conteinerView.snp.makeConstraints { make in
            make.topMargin.equalToSuperview()
            make.width.equalToSuperview()
            make.height.greaterThanOrEqualTo(268)
            make.height.lessThanOrEqualTo(338)
        }
        imageОfЕheLeftCloud.snp.makeConstraints { make in
            make.top.equalTo(topImageView.snp.top)
            make.left.equalTo(-35)
            make.width.equalTo(169)
            make.height.equalTo(104)
        }
        imageОfЕheRightCloud.snp.makeConstraints { make in
            make.top.equalTo(topImageView.snp.bottom).inset(56)
            make.right.equalTo(40)
            make.width.equalTo(124.12)
            make.height.equalTo(79.15)
        }
        addButton.snp.makeConstraints { make in
            make.top.equalTo(conteinerView.snp.bottom).inset(31)
            make.centerX.equalToSuperview()
            make.width.height.equalTo(62)
        }
        buttonImage.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
            make.width.height.equalTo(27)
        }
        topImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.width.greaterThanOrEqualTo(74)
            make.width.lessThanOrEqualTo(112)
            make.height.greaterThanOrEqualTo(74)
            make.height.lessThanOrEqualTo(112)
            make.bottom.equalToSuperview().inset(40)
        }
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(conteinerView.snp.bottom).offset(30)
            make.width.equalTo(100)
            make.height.equalTo(22)
            make.left.equalTo(30)
        }
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(conteinerView.snp.bottom).offset(70)
            make.width.equalToSuperview()
            make.height.greaterThanOrEqualTo(330)
            make.height.lessThanOrEqualToSuperview()
            make.bottom.equalToSuperview()
        }
        subTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(collectionView.snp.top).offset(40)
            make.centerX.equalToSuperview()
            make.width.equalTo(166)
            make.height.equalTo(43)
        }
    }
}
//MARK: - extension for UICollectionView
extension FlightsController: UICollectionViewDelegateFlowLayout,
                            UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width  = collectionView.frame.width - 21
        return CGSize(width: width,
                      height: 89)
    }
    func collectionView(_ collectionView: UICollectionView,
                        willDisplay cell: UICollectionViewCell,
                        forItemAt indexPath: IndexPath) {
        if indexPath.item < 0 {
            titleLabel.isHidden = true
            subTitleLabel.isHidden = false
        } else {
            titleLabel.isHidden = false
            subTitleLabel.isHidden = true
        }
    }
}
//MARK: - extension for DiffableDataSource
extension FlightsController {
    func configureDataSourse() {
        let cellRegistration = UICollectionView.CellRegistration
        <InspectionCollectionCell,
         FlightsList> { (cell,
                  indexPath,
                  model) in
            cell.coreManager = self.coreManager
            cell.viewModel = self.viewModel
            cell.flightsView()
            cell.startButton.tag = Int(model.id)
             guard let date = model.checkBefore else { return }
             let formatter = DateFormatter()
             formatter.dateFormat = "dd.MM.yy"
             cell.dateTitle.text = formatter.string(from: date)
             cell.nameLabel.text = model.name
        }
        dataSource = UICollectionViewDiffableDataSource<Sections,
                                                        FlightsList> (collectionView: collectionView) {
            (collectionView: UICollectionView,
             indexPath: IndexPath,
             identifier: FlightsList) -> UICollectionViewCell? in
            let cell = collectionView.dequeueConfiguredReusableCell(using: cellRegistration,
                                                                    for: indexPath,
                                                                    item: identifier)
            return cell
        }
    }
//MARK: createSnapsShot
    func createSnapsShot(model: [FlightsList]) {
        var snapsShot = NSDiffableDataSourceSnapshot<Sections,
                                                     FlightsList>()
        snapsShot.appendSections([.flights])
        snapsShot.appendItems(model)
        dataSource?.apply(snapsShot,
                         animatingDifferences: true)
    }
}
extension FlightsController: FlightsVCDelegate {
    func reloadData() {
        self.setupeFetchRequest()
    }
}
