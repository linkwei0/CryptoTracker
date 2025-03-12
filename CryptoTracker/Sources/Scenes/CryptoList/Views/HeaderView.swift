//
//  HeaderView.swift
//  CryptoTracker
//
//  Created by Артём Бацанов on 12.03.2025.
//

import UIKit

final class HeaderView: UIView {
    
    // MARK: - UI Components
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Home"
        label.textColor = .baseWhite
        label.font = .boldSystemFont(ofSize: 24)
        return label
    }()
    
    private let affiliateLabel: UILabel = {
        let label = UILabel()
        label.text = "Affiliate program"
        label.textColor = .baseWhite
        label.font = .systemFont(ofSize: 16)
        return label
    }()
    
    private let learnMoreButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .baseWhite
        button.layer.cornerRadius = 35 / 2
        button.setTitle("Learn more", for: .normal)
        button.setTitleColor(.baseBlack, for: .normal)
        button.titleLabel?.font = UIFont.body
        button.snp.makeConstraints { make in
            make.width.equalTo(127)
            make.height.equalTo(35)
        }
        return button
    }()
    
    private let backgroundImage: UIImageView = {
        let imageView = UIImageView(image: UIImage.backgroundIcon)
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.snp.makeConstraints { make in
            make.width.height.equalTo(242)
        }
        return imageView
    }()
    
    let settingsButton = SettingsButton()
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup
    private func setupUI() {
        backgroundColor = .accentPink
        layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
        layer.cornerRadius = 20
        
        addSubview(titleLabel)
        addSubview(settingsButton)
        addSubview(affiliateLabel)
        addSubview(learnMoreButton)
        addSubview(backgroundImage)
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(60)
            make.leading.equalToSuperview().inset(20)
        }
        
        settingsButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(60)
            make.trailing.equalToSuperview().inset(20)
            make.width.height.equalTo(48)
        }
        
        affiliateLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(38)
            make.leading.equalToSuperview().inset(20)
        }
        
        learnMoreButton.snp.makeConstraints { make in
            make.top.equalTo(affiliateLabel.snp.bottom).offset(12)
            make.leading.equalToSuperview().inset(20)
            make.width.equalTo(127)
            make.height.equalTo(35)
        }
        
        backgroundImage.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(-30)
            make.bottom.equalToSuperview().inset(-52)
        }
    }
    
    // MARK: - Public Methods
    func setSettingsAction(target: Any, action: Selector) {
        settingsButton.addTarget(target, action: action, for: .touchUpInside)
    }
    
    func setLearnMoreAction(target: Any, action: Selector) {
        learnMoreButton.addTarget(target, action: action, for: .touchUpInside)
    }
}

