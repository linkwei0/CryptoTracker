//
//  CryptoListViewModel.swift
//  CryptoTracker
//
//  Created by Артём Бацанов on 11.03.2025.
//

import Foundation

protocol CryptoListViewModelDelegate: AnyObject {
    func viewModelDidRequestToShowDetails(_ viewModel: CryptoListViewModel, for crypto: Crypto)
    func viewModelDidRequestToShowAuth(_ viewModel: CryptoListViewModel)
}

class CryptoListViewModel: TableViewModel, ViewStateHandleable {
    // MARK: - Properties
    weak var delegate: CryptoListViewModelDelegate?
    
    var sectionViewModels: [TableSectionViewModel] {
        let section = TableSectionViewModel()
        section.append(cellViewModels: itemViewModels)
        return [section]
    }
    
    let viewState: Bindable<ViewState<TableCellViewModel>> = .init(.loading)
    
    private var itemViewModels: [TableCellViewModel] = []
    private var cryptos: [Crypto] = []
    
    private let interactor: CryptoListInteractor
    
    // MARK: - Init
    init(interactor: CryptoListInteractor) {
        self.interactor = interactor
    }
    
    // MARK: - Public methods
    func viewIsReady() {
        loadData()
    }
    
    func didTapFilter(option: FilterType) {
        switch option {
        case .ascending:
            cryptos.sort { $0.price < $1.price }
        case .descending:
            cryptos.sort { $0.price > $1.price }
        }
        
        itemViewModels = cryptos.map { crypto in
            let itemViewModel = CryptoCellViewModel(crypto: crypto)
            itemViewModel.delegate = self
            return itemViewModel
        }
        
        viewState.value = handleableResult(itemViewModels)
    }
    
    func signOut() {
        interactor.signOut()
        delegate?.viewModelDidRequestToShowAuth(self)
    }
    
    // MARK: - Private methods
    private func loadData() {
        interactor.loadData(symbols: Constants.symbols) { [weak self] cryptos in
            guard let self else { return }
            self.cryptos = cryptos
            
            self.itemViewModels = cryptos.map { crypto in
                let itemViewModel = CryptoCellViewModel(crypto: crypto)
                itemViewModel.delegate = self
                return itemViewModel
            }
            
            self.viewState.value = self.handleableResult(itemViewModels)
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

// MARK: - Enums
enum FilterType {
    case ascending
    case descending
}

typealias CryptoViewState = ViewState<TableCellViewModel>
