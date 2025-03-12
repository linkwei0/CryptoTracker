//
//  UIView+Shadow.swift
//  CryptoTracker
//
//  Created by Артём Бацанов on 11.03.2025.
//

import UIKit

extension UIView {
    func addShadow(color: UIColor = .baseBlack, offset: CGSize = CGSize(width: 0, height: 20),
                   opacity: Float = 0.25, radius: CGFloat = 30) {
        layer.shadowColor = color.cgColor
        layer.shadowOffset = offset
        layer.shadowOpacity = opacity
        layer.shadowRadius = radius
        layer.masksToBounds = false
    }
}
