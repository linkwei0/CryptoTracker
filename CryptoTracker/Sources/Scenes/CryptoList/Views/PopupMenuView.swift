//
//  PopupMenuView.swift
//  CryptoTracker
//
//  Created by User on 12.03.2025.
//

import UIKit

protocol PopupMenuViewDelegate: AnyObject {
    func popupMenuDidTapSignOut(_ popupMenuView: PopupMenuView)
    func popupMenuDidTapRefresh(_ popupMenuView: PopupMenuView)
}

extension PopupMenuViewDelegate {
    func popupMenuDidTapRefresh(_ popupMenuView: PopupMenuView) {}
}

class PopupMenuView: UIView {
    // MARK: - Properties
    weak var delegate: PopupMenuViewDelegate?
    
    private let containerView = UIView()
    private let refreshButton = UIButton()
    private let logoutButton = UIButton()
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    // MARK: - Actions
    @objc private func refreshTapped() {
        delegate?.popupMenuDidTapRefresh(self)
        removeFromSuperview()
    }
    
    @objc private func logoutTapped() {
        delegate?.popupMenuDidTapSignOut(self)
        removeFromSuperview()
    }
    
    // MARK: - Setup
    private func setup() {
        setupContainerView()
        setupRefreshButton()
        setupLogoutButton()
    }
    
    private func setupContainerView() {
        addSubview(containerView)
        containerView.backgroundColor = .baseWhite
        containerView.layer.cornerRadius = 12
        containerView.clipsToBounds = true
        containerView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.width.equalTo(150)
            make.height.equalTo(100)
        }
    }
    
    private func setupRefreshButton() {
        containerView.addSubview(refreshButton)
        
        let stackView = createStackView(image: .rocket, text: "Обновить")
        refreshButton.addSubview(stackView)
        
        stackView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(10)
        }
        
        refreshButton.backgroundColor = .clear
        refreshButton.addTarget(self, action: #selector(refreshTapped), for: .touchUpInside)
        
        refreshButton.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(8)
            make.leading.equalToSuperview().inset(16)
        }
    }

    private func setupLogoutButton() {
        containerView.addSubview(logoutButton)
        
        let stackView = createStackView(image: .trash, text: "Выйти")
        logoutButton.addSubview(stackView)
        
        stackView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(6)
        }
        
        logoutButton.backgroundColor = .clear
        logoutButton.addTarget(self, action: #selector(logoutTapped), for: .touchUpInside)
        
        logoutButton.snp.makeConstraints { make in
            make.top.equalTo(refreshButton.snp.bottom).offset(2)
            make.leading.equalToSuperview().inset(16)
        }
    }

    private func createStackView(image: UIImage, text: String) -> UIStackView {
        let imageView = UIImageView(image: image)
        imageView.tintColor = .baseBlack
        imageView.contentMode = .scaleAspectFit
        imageView.snp.makeConstraints { make in
            make.size.equalTo(20)
        }
        
        let label = UILabel()
        label.text = text
        label.textColor = .baseBlack
        label.font = UIFont.appRegular
        
        let stackView = UIStackView(arrangedSubviews: [imageView, label])
        stackView.isUserInteractionEnabled = false
        stackView.axis = .horizontal
        stackView.spacing = 8
        stackView.alignment = .center
        
        return stackView
    }
}
