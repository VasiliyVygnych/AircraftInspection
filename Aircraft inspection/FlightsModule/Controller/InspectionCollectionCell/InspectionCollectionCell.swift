//
//  InspectionCollectionCell.swift
//  Aircraft inspection
//
//  Created by Vasiliy Vygnych on 09.04.2024.
//

import UIKit
import SnapKit

class InspectionCollectionCell: UICollectionViewCell {
  
    var viewModel: FlightsVMProtocol?
    var coreManager: CoreDataManagerProtocol?
    
//MARK: UILabel
   private var dateLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor(named: "white66")
       label.font = .RobotoFlex(ofSize: 14.8,
                                 weight: ._300)
        return label
    }()
    var dateTitle: UILabel = {
        let label = UILabel()
         label.translatesAutoresizingMaskIntoConstraints = false
         label.textColor = UIColor(named: "white66")
         label.font = .RobotoFlex(ofSize: 14.8,
                                  weight: ._300)
         return label
     }()
    var nameLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.font = .RobotoFlex(ofSize: 20,
                                 weight: ._900)
        label.textAlignment = .left
        return label
    }()
   private var buttonTitle: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.font = .RobotoFlex(ofSize: 13,
                                 weight: ._500)
        label.textAlignment = .center
        return label
    }()
//MARK: UIButton
    var startButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 10
        button.backgroundColor = UIColor(named: "basikRed")
        return button
    }()
//MARK: init
    override init(frame: CGRect) {
        super.init(frame: frame)
        buttonTitle.text = "Start checking"
        addSubview()
        сreatedConstraints()
        setupeButton()
        contentView.backgroundColor = UIColor(named: "basikGray")
        contentView.layer.cornerRadius = 11
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func flightsView() {
        dateLabel.text = "Check before"
    }
    func analyticsView() {
        dateLabel.text = "Report from the"
        startButton.isHidden = true
    }
}
//MARK: - extension
private extension InspectionCollectionCell {
    func addSubview() {
        contentView.addSubview(dateLabel)
        contentView.addSubview(dateTitle)
        contentView.addSubview(nameLabel)
        contentView.addSubview(startButton)
        startButton.addSubview(buttonTitle)
    }
//MARK: - setupeButton
    private func setupeButton() {
        startButton.addTarget(self,
                              action: #selector(start),
                              for: .touchUpInside)
    }
    @objc func start() {
        viewModel?.clickAnimate(view: startButton)
        let model = coreManager?.searchInspectionList(id: startButton.tag)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.viewModel?.presentAircraftInspectionView(model: model)
        }
    }
//MARK: - сreatedConstraints
    func сreatedConstraints() {
        dateLabel.snp.makeConstraints { make in
            make.top.equalTo(15)
            make.height.equalTo(27)
            make.width.greaterThanOrEqualTo(95)
            make.left.equalTo(29)
        }
        dateTitle.snp.makeConstraints { make in
            make.top.equalTo(15)
            make.height.equalTo(27)
            make.width.equalTo(65)
            make.left.equalTo(dateLabel.snp.right).inset(-5)
        }
        nameLabel.snp.makeConstraints { make in
            make.height.equalTo(27)
            make.width.equalTo(150)
            make.left.equalTo(29)
            make.bottom.equalTo(-15)
        }
        startButton.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.height.equalTo(39)
            make.width.equalTo(124)
            make.right.equalTo(-29)
        }
        buttonTitle.snp.makeConstraints { make in
            make.centerY.centerX.equalToSuperview()
            make.height.equalTo(28)
            make.width.equalTo(95)
        }
    }
}
