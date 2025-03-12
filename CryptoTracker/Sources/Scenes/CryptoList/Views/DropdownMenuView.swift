//
//  DropDownMenuView.swift
//  CryptoTracker
//
//  Created by User on 12.03.2025.
//

import UIKit

final class DropdownMenuView: UIView {
    
    // MARK: - Properties
    var didSelectOption: ((SortOption) -> Void)?
    
    private let stackView = UIStackView()
    private let ascendingButton = UIButton()
    private let descendingButton = UIButton()
    
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
        backgroundColor = .white
        layer.cornerRadius = 12
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.2
        layer.shadowOffset = CGSize(width: 0, height: 4)
        layer.shadowRadius = 8
        
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 0
        
        setupButton(ascendingButton, title: "🔼 По возрастанию", action: #selector(didTapAscending))
        setupButton(descendingButton, title: "🔽 По убыванию", action: #selector(didTapDescending))
        
        addSubview(stackView)
        stackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    private func setupButton(_ button: UIButton, title: String, action: Selector) {
        button.setTitle(title, for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        button.contentHorizontalAlignment = .left
        button.addTarget(self, action: action, for: .touchUpInside)
        button.backgroundColor = .white
        stackView.addArrangedSubview(button)
    }
    
    // MARK: - Actions
    @objc private func didTapAscending() {
        didSelectOption?(.ascending)
        removeFromSuperview()
    }
    
    @objc private func didTapDescending() {
        didSelectOption?(.descending)
        removeFromSuperview()
    }
}

// MARK: - Sort Options Enum
enum SortOption {
    case ascending
    case descending
}
