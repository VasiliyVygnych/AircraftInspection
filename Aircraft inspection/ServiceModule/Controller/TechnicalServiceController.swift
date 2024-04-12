//
//  TechnicalServiceController.swift
//  Aircraft inspection
//
//  Created by Vasiliy Vygnych on 29.03.2024.
//

import UIKit
import SnapKit
import CoreData

class TechnicalServiceController: BaseViewController {
    
    var viewModel: TSViewModelProtocol?
    var coreManager: CoreDataManagerProtocol?
    
    private var dataSource: UICollectionViewDiffableDataSource<Sections,
                                                               AirplaneList>?
    lazy var sortDescriptor = NSSortDescriptor(key: "id",
                                          ascending: false)
    let fetchRequest = NSFetchRequest<AirplaneList>(entityName: "AirplaneList")
    
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
        view.image = UIImage(named: "topAirplan")
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
        label.adjustsFontForContentSizeCategory = true
        label.textAlignment = .center
        label.text = "Airplane"
        return label
    }()
    private var topSubtitleLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor(named: "black46")
        label.font = .RobotoFlex(ofSize: 15,
                                 weight: ._400)
        label.textAlignment = .center
        label.text = "Add your airplane for maintenance"
        return label
    }()
    private var titleLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.font = .RobotoFlex(ofSize: 15,
                                 weight: ._300)
        label.textAlignment = .left
        label.text = "Your planes"
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
        label.text = "Add your aircraft for maintenance"
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
        collectionView.isUserInteractionEnabled = true
        return collectionView
   }()
//MARK: viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubview()
        setupecollectionView()
        setupeConstraint()
        setupeButton()
        configureDataSourse()
        titleLabel.isHidden = true
        subTitleLabel.isHidden = false
    }
//MARK: viewWillAppear
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        setupeFetchRequest()
        settingUpTheView(.defaults)
        navigationController?.navigationBar.isHidden = true
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
        collectionView.register(CollectionViewCell.self,
                                forCellWithReuseIdentifier: "cell")
    }
//MARK: addSubview
    private func addSubview() {
        viewModel?.setMainController(controller: self)
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
        viewModel?.presentAddingAirplaneCardView()
    }
    @objc func settings() {
        viewModel?.presentSettingsController()
    }
//MARK: setupeConstraint
    private func setupeConstraint() {
        conteinerView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.width.equalToSuperview()
            make.height.equalTo(338)
        }
        topLabel.snp.makeConstraints { make in
            make.top.equalTo(86)
            make.centerX.equalToSuperview()
            make.height.equalTo(22)
            make.width.equalTo(97)
        }
        topSubtitleLabel.snp.makeConstraints { make in
            make.top.equalTo(112)
            make.centerX.equalToSuperview()
            make.height.equalTo(22)
            make.width.equalTo(260)
        }
        settingsButton.snp.makeConstraints { make in
            make.top.equalTo(84)
            make.right.equalTo(-20)
            make.width.height.equalTo(24)
        }
        imageОfЕheLeftCloud.snp.makeConstraints { make in
            make.top.equalTo(159)
            make.left.equalTo(-35)
            make.width.equalTo(169)
            make.height.equalTo(104)
        }
        imageОfЕheRightCloud.snp.makeConstraints { make in
            make.top.equalTo(243)
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
            make.top.equalTo(163)
            make.centerX.equalToSuperview()
            make.width.equalTo(254)
            make.height.equalTo(94)
        }
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(379)
            make.width.equalTo(85)
            make.height.equalTo(22)
            make.left.equalTo(30)
        }
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
            make.width.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        subTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(543)
            make.centerX.equalToSuperview()
            make.width.equalTo(166)
            make.height.equalTo(43)
        }
    }
}
//MARK: - extension for UICollectionView
extension TechnicalServiceController: UICollectionViewDelegateFlowLayout,
                            UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width  = collectionView.frame.width - 21
        return CGSize(width: width,
                      height: 108)
    }
    func collectionView(_ collectionView: UICollectionView,
                        didSelectItemAt indexPath: IndexPath) {
        guard let collectionView = self.collectionView.cellForItem(at: indexPath),
              let model = dataSource?.itemIdentifier(for: indexPath) else { return }
        UIView.animate(withDuration: 0.3,
                       delay: 0,
                       options: .curveEaseOut,
                       animations: {
            collectionView.transform = CGAffineTransform(scaleX: 0.95,
                                                         y: 0.95)
        }, completion: { finished in
            self.viewModel?.showDeailAirplaneCard(model: model)
            UIView.animate(withDuration: 0.3,
                           delay: 0,
                           options: .curveEaseOut,
                           animations: {
                collectionView.transform = CGAffineTransform(scaleX: 1,
                                                             y: 1)
            }, completion: nil)
        })
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
extension TechnicalServiceController {
    func configureDataSourse() {
        let cellRegistration = UICollectionView.CellRegistration
        <CollectionViewCell,
         AirplaneList> { (cell,
                  indexPath,
                  model) in
            cell.tSConstreint()
            cell.imageView.image = UIImage(named: "topAirplan")
            cell.nameLabel.text = model.name
            cell.descriptionLabel.text = model.model
        }
        dataSource = UICollectionViewDiffableDataSource<Sections,
                                                        AirplaneList> (collectionView: collectionView) {
            (collectionView: UICollectionView,
             indexPath: IndexPath,
             identifier: AirplaneList) -> UICollectionViewCell? in
            let cell = collectionView.dequeueConfiguredReusableCell(using: cellRegistration,
                                                                    for: indexPath,
                                                                    item: identifier)
            return cell
        }
    }
//MARK: createSnapsShot
    func createSnapsShot(model: [AirplaneList]) {
        var snapsShot = NSDiffableDataSourceSnapshot<Sections,
                                                     AirplaneList>()
        snapsShot.appendSections([.servis])
        snapsShot.appendItems(model)
        dataSource?.apply(snapsShot,
                         animatingDifferences: true)
    }
}
extension TechnicalServiceController: TSViewControllerDelegate {
    func reloadData() {
        setupeFetchRequest()
    }
}
