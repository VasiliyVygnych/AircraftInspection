//
//  CollectionViewCell.swift
//  Aircraft inspection
//
//  Created by Vasiliy Vygnych on 29.03.2024.
//

import UIKit
import SnapKit

class CollectionViewCell: UICollectionViewCell {
  
//MARK: UIView
    private var conteinerView: UIView = {
       let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(named: "basikGray")
        view.layer.cornerRadius = 11
        return view
    }()
    private var separatorView: UIView = {
       let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(named: "gray25")
        return view
    }()
//MARK: UIImageView
    var imageView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFill
       return image
    }()
    private var buttonImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFill
        image.image = UIImage(named: "arrow-right")
       return image
    }()
//MARK: UILabel
    var nameLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.font = .RobotoFlex(ofSize: 21.14,
                                 weight: ._900)
        label.textAlignment = .left
        return label
    }()
    var descriptionLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor(named: "white66")
        label.font = .RobotoFlex(ofSize: 14.8,
                                 weight: ._300)
        return label
    }()
//MARK: UIButton
    private var detailButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 15.5
        button.backgroundColor = .white
        return button
    }()
//MARK: init
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview()
        сreatedConstraints()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
//MARK: Constreint
    func tSConstreint() {
        imageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalTo(29)
            make.width.equalTo(144.84)
            make.height.equalTo(52.86)
        }
        separatorView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalTo(imageView.snp.right).offset(10)
            make.width.equalTo(1)
            make.height.equalTo(41)
        }
        nameLabel.snp.makeConstraints { make in
            make.left.equalTo(separatorView.snp.right).inset(-20)
            make.width.lessThanOrEqualTo(160)
            make.height.equalTo(27)
            make.bottom.equalTo(conteinerView.snp.centerY).offset(5)
        }
    }
    func monitoringConstreint() {
        imageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalTo(29)
            make.width.equalTo(37)
            make.height.equalTo(30)
        }
        separatorView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalTo(imageView.snp.right).offset(20)
            make.width.equalTo(1)
            make.height.equalTo(41)
        }
        nameLabel.snp.makeConstraints { make in
            make.left.equalTo(separatorView.snp.right).inset(-40)
            make.width.lessThanOrEqualTo(220)
            make.height.equalTo(27)
            make.centerY.equalToSuperview()
        }
    }
}
//MARK: - extension
private extension CollectionViewCell {
    func addSubview() {
        contentView.addSubview(conteinerView)
        conteinerView.addSubview(detailButton)
        conteinerView.addSubview(imageView)
        conteinerView.addSubview(nameLabel)
        conteinerView.addSubview(descriptionLabel)
        conteinerView.addSubview(separatorView)
        detailButton.addSubview(buttonImage)
    }
//MARK: - setupeConstraint
    func сreatedConstraints() {
        conteinerView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.height.equalToSuperview()
            make.left.equalToSuperview()
            make.right.equalTo(-20)
            make.bottom.equalToSuperview()
        }
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(conteinerView.snp.centerY).offset(5)
            make.left.equalTo(separatorView.snp.right).offset(20)
            make.width.equalTo(140)
            make.height.equalTo(27)
        }
        detailButton.snp.makeConstraints { make in
            make.width.height.equalTo(31)
            make.centerY.equalToSuperview()
            make.centerX.equalTo(conteinerView.snp.right)
        }
        buttonImage.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
            make.width.height.equalTo(18.24)
        }
    }
}
