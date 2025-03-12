//
//  CryptoCell.swift
//  CryptoTracker
//
//  Created by Артём Бацанов on 11.03.2025.
//

import UIKit

class CryptoCell: UITableViewCell, TableCell {
    // MARK: - Properties
    private let mainImageView = UIImageView()
    private let nameLabel = UILabel()
    private let shortNameLabel = UILabel()
    private let priceLabel = UILabel()
    private let dynamicsLabel = UILabel()
    private let dynamicsIcon = UIImageView()
    
    // MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    // MARK: - Configure
    func configure(with viewModel: TableCellViewModel) {
        guard let viewModel = viewModel as? CryptoCellViewModel else { return }
        
        mainImageView.image = UIImage(named: viewModel.imageName)
        nameLabel.text = viewModel.title
        shortNameLabel.text = viewModel.shortName
        priceLabel.text = viewModel.price
        dynamicsLabel.text = viewModel.dynamics
        dynamicsIcon.image = viewModel.isIncreased ? UIImage(systemName: "arrow.up") : UIImage(systemName: "arrow.down")
    }
    
    // MARK: - Setup
    private func setup() {
        setupBackground()
        setupMainImage()
        setupNameLabel()
        setupShortNmaeLabel()
        setupPriceLabel()
        setupDynamicsLabel()
    }
    
    private func setupBackground() {
        selectionStyle = .none
    }
    
    private func setupMainImage() {
        contentView.addSubview(mainImageView)
        mainImageView.contentMode = .scaleAspectFit
        mainImageView.layer.cornerRadius = 20
        mainImageView.clipsToBounds = true
        mainImageView.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(20)
            make.centerY.equalToSuperview()
            make.width.height.equalTo(40)
        }
    }
    
    private func setupNameLabel() {
        contentView.addSubview(nameLabel)
        nameLabel.font = UIFont(name: "Poppins-Bold", size: 18)
        nameLabel.textColor = .baseBlack
        nameLabel.snp.makeConstraints { make in
            make.leading.equalTo(mainImageView.snp.trailing).offset(10)
            make.top.equalToSuperview().offset(10)
        }
    }
    
    private func setupShortNmaeLabel() {
        contentView.addSubview(shortNameLabel)
        shortNameLabel.font = UIFont(name: "Poppins-Regular", size: 14)
        shortNameLabel.textColor = .lightGray
        shortNameLabel.snp.makeConstraints { make in
            make.leading.equalTo(nameLabel)
            make.top.equalTo(nameLabel.snp.bottom).offset(2)
        }
    }
    
    private func setupPriceLabel() {
        contentView.addSubview(priceLabel)
        priceLabel.font = UIFont(name: "Poppins-Regular", size: 18)
        priceLabel.textColor = .baseBlack
        priceLabel.textAlignment = .right
        priceLabel.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(20)
            make.top.equalToSuperview().offset(10)
        }
    }
    
    private func setupDynamicsLabel() {
        contentView.addSubview(dynamicsLabel)
        dynamicsLabel.font = UIFont(name: "Poppins-Bold", size: 14)
        dynamicsLabel.textColor = .lightGray
        dynamicsLabel.textAlignment = .right
        dynamicsLabel.snp.makeConstraints { make in
            make.trailing.equalTo(priceLabel)
            make.top.equalTo(priceLabel.snp.bottom).offset(2)
        }
        
        contentView.addSubview(dynamicsIcon)
        dynamicsIcon.contentMode = .scaleAspectFit
        dynamicsIcon.snp.makeConstraints { make in
            make.trailing.equalTo(dynamicsLabel.snp.leading).offset(-5)
            make.centerY.equalTo(dynamicsLabel)
            make.width.height.equalTo(12)
        }
    }
}
