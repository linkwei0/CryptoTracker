//
//  SegmetedControlView.swift
//  CryptoTracker
//
//  Created by User on 12.03.2025.
//

import UIKit

protocol SegmentedControlViewDelegate: AnyObject {
    func segmentedControlView(_ view: SegmentedControlView, didSelect type: SegmentedControlType)
}

final class SegmentedControlView: UIView {
    
    // MARK: - Properties
    weak var delegate: SegmentedControlViewDelegate?
    
    private let options: [SegmentedControlType]
    private var selectedIndex: Int = 0
    private var labels: [UILabel] = []
    
    private lazy var stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .fillEqually
        stack.spacing = 5
        return stack
    }()
    
    // MARK: - Init
    init(options: [SegmentedControlType]) {
        self.options = options
        super.init(frame: .zero)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure() {
        selectIndex(0, animated: false)
    }
    
    // MARK: - Setup
    private func setupUI() {
        backgroundColor = .shade1
        layer.cornerRadius = 20
        clipsToBounds = true
        
        addSubview(stackView)
        stackView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(5)
        }
        
        for (index, type) in options.enumerated() {
            let label = createLabel(title: type.title, index: index)
            labels.append(label)
            stackView.addArrangedSubview(label)
            
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(labelTapped(_:)))
            label.isUserInteractionEnabled = true
            label.addGestureRecognizer(tapGesture)
        }
        
        if !labels.isEmpty {
            selectIndex(0, animated: false)
        }
    }
    
    private func createLabel(title: String, index: Int) -> UILabel {
        let label = Label(textStyle: .body)
        label.text = title
        label.textColor = .textSecondary
        label.textAlignment = .center
        label.tag = index
        label.layer.cornerRadius = 15
        label.layer.masksToBounds = true
        return label
    }
    
    // MARK: - Actions
    @objc private func labelTapped(_ sender: UITapGestureRecognizer) {
        guard let label = sender.view as? UILabel else { return }
        selectIndex(label.tag, animated: true)
        delegate?.segmentedControlView(self, didSelect: options[label.tag])
    }
    
    // MARK: - Selection Handling
    func selectIndex(_ index: Int, animated: Bool) {
        guard index < labels.count else { return }
        
        let previousLabel = labels[selectedIndex]
        previousLabel.textColor = .textSecondary
        previousLabel.backgroundColor = .clear
        
        let selectedLabel = labels[index]
        selectedLabel.textColor = .baseBlack
        selectedLabel.backgroundColor = .baseWhite
        
        selectedIndex = index
    }
}

// MARK: - Enums
enum SegmentedControlType {
    case day
    case week
    case year
    case all
    case point
    
    var title: String {
        switch self {
        case .day:
            return "24H"
        case .week:
            return "1W"
        case .year:
            return "1Y"
        case .all:
            return "ALL"
        case .point:
            return "Point"
        }
    }
}
