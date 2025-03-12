//
//  SettingsButton.swift
//  CryptoTracker
//
//  Created by Артём Бацанов on 11.03.2025.
//

import UIKit

class SettingsButton: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        backgroundColor = .baseWhite
        layer.cornerRadius = 24
        layer.masksToBounds = false

        let config = UIImage.SymbolConfiguration(pointSize: 24, weight: .bold)
        let image = UIImage(systemName: "ellipsis", withConfiguration: config)
        
        setImage(image, for: .normal)
        tintColor = .black
    }
}
