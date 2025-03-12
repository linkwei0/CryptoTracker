//
//  CryptoCellViewModel.swift
//  CryptoTracker
//
//  Created by User on 12.03.2025.
//

import Foundation

protocol CryptoCellViewModelDelegate: AnyObject {
    func cellViewModelDidSelect(_ viewModel: CryptoCellViewModel, for crypto: Crypto)
}

class CryptoCellViewModel {
    // MARK: - Properties
    weak var delegate: CryptoCellViewModelDelegate?
    
    var imageName: String {
        return "user-icon"
    }
    
    var title: String {
        return crypto.name
    }
    
    var shortName: String {
        return crypto.symbol
    }
    
    var price: String {
        return crypto.price.toRounadableString()
    }
    
    var dynamics: String {
        return crypto.price24H.toRounadableString()
    }
    
    var isIncreased: Bool {
        return crypto.price24H > 0
    }
    
    let crypto: Crypto
    
    // MARK: - Init
    init(crypto: Crypto) {
        self.crypto = crypto
    }
}

// MARK: - TableCellViewModel
extension CryptoCellViewModel: TableCellViewModel {
    var tableReuseIdentifier: String {
        return CryptoCell.reuseIdentifier
    }
    
    func select() {
        delegate?.cellViewModelDidSelect(self, for: crypto)
    }
}
