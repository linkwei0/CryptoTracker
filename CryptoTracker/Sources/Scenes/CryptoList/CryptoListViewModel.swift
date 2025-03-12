//
//  CryptoListViewModel.swift
//  CryptoTracker
//
//  Created by Артём Бацанов on 11.03.2025.
//

import Foundation

protocol CryptoListViewModelDelegate: AnyObject {
    func viewModelDidRequestToShowDetails(_ viewModel: CryptoListViewModel, for crypto: Crypto)
}

class CryptoListViewModel: TableViewModel, ViewStateHandleable {
    // MARK: - Properties
    weak var delegate: CryptoListViewModelDelegate?
    
    var onNeedsToUpdate: (() -> Void)?
    
    var sectionViewModels: [TableSectionViewModel] {
        let section = TableSectionViewModel()
        section.append(cellViewModels: itemViewModels)
        return [section]
    }
    
    private var itemViewModels: [TableCellViewModel] = []
    
    private let interactor: CryptoListInteractor
    
    // MARK: - Init
    init(interactor: CryptoListInteractor) {
        self.interactor = interactor
    }
    
    // MARK: - Public methods
    func viewIsReady() {
        loadData()
    }
    
    // MARK: - Private methods
    private func loadData() {
        interactor.loadData(symbols: Constants.symbols) { [weak self] cryptos in
            self?.itemViewModels = cryptos.map { crypto in
                let itemViewModel = CryptoCellViewModel(crypto: crypto)
                itemViewModel.delegate = self
                return itemViewModel
            }
            
            self?.onNeedsToUpdate?()
        }
    }
}

// MARK: - CryptoCellViewModelDelegate
extension CryptoListViewModel: CryptoCellViewModelDelegate {
    func cellViewModelDidSelect(_ viewModel: CryptoCellViewModel, for crypto: Crypto) {
        delegate?.viewModelDidRequestToShowDetails(self, for: crypto)
    }
}

// MARK: - Constants
private extension Constants {
    static let symbols = ["btc", "eth", "tron", "luna", "polkadot",
                          "dogecoin", "tether", "stellar", "cardano", "xrp"]
}
