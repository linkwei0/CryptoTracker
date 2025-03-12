//
//  CryptoType.swift
//  CryptoTracker
//
//  Created by Артём Бацанов on 12.03.2025.
//

import UIKit

enum CryptoType: String {
    case btc = "BTC"
    case others
    
    var image: UIImage {
        switch self {
        case .btc:
            return .btcIcon
        case .others:
            let image = [UIImage.neoIcon, UIImage.achaIcon].randomElement()
            return image ?? .btcIcon
        }
    }
}
