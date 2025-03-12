//
//  CryptoDetailsViewModel.swift
//  CryptoTracker
//
//  Created by User on 12.03.2025.
//

import Foundation

protocol CryptoDetailsViewModelDelegate: AnyObject {
    func viewModelDidRequestToBack(_ viewModel: CryptoDetailsViewModel)
    func viewModelDidRequestToSignOut(_ viewModel: CryptoDetailsViewModel)
}

class CryptoDetailsViewModel {
    // MARK: - Properties
    weak var delegate: CryptoDetailsViewModelDelegate?
    
    var onNeedsToUpdate: ((String?, String?, String?, String?, String?, Bool) -> Void)?
    
    private var title: String?
    private var price: String?
    private var percentageChange: String?
    private var marketCap: String?
    private var circulatingSupplyValue: String?
    
    private let crypto: Crypto
    private let interactor: CryptoDetailsInteractor
    
    // MARK: - Init
    init(crypto: Crypto, interactor: CryptoDetailsInteractor) {
        self.crypto = crypto
        self.interactor = interactor
    }
    
    // MARK: - Public methods
    func viewIsReady() {
        title = crypto.name + " " + "(\(crypto.symbol))"
        configureDay()
    }
    
    func didTapBack() {
        delegate?.viewModelDidRequestToBack(self)
    }
    
    func signOut() {
        interactor.signOut()
        delegate?.viewModelDidRequestToSignOut(self)
    }
    
    func didSelectType(_ type: SegmentedControlType) {
        switch type {
        case .day:
            configureDay()
        case .week:
            configureWeek()
        case .year:
            configureYear()
        case .all:
            // etc
            break
        case .point:
            // etc
            break
        }
    }
    
    // MARK: - Private methods
    private func configureDay() {
        price = "$" + crypto.price.toRounadableString()
        percentageChange = crypto.percentChange24Hours.toRounadableString() + "%"
        marketCap = "$" + crypto.marketCap.toRounadableString()
        circulatingSupplyValue = crypto.supply.toRounadableString() + " " + crypto.symbol
        let isIncreased = crypto.percentChange24Hours > 0
        onNeedsToUpdate?(title, price, percentageChange, marketCap, circulatingSupplyValue, isIncreased)
    }
    
    private func configureWeek() {
        price = "$" + crypto.price.toRounadableString()
        percentageChange = crypto.percentChange1Week.toRounadableString() + "%"
        marketCap = "$" + crypto.marketCap.toRounadableString()
        circulatingSupplyValue = crypto.supply.toRounadableString() + " " + crypto.symbol
        let isIncreased = crypto.percentChange1Week > 0
        onNeedsToUpdate?(title, price, percentageChange, marketCap, circulatingSupplyValue, isIncreased)
    }
    
    private func configureYear() {
        price = "$" + crypto.price.toRounadableString()
        percentageChange = crypto.percentChange1Year.toRounadableString() + "%"
        marketCap = "$" + crypto.marketCap.toRounadableString()
        circulatingSupplyValue = crypto.supply.toRounadableString() + " " + crypto.symbol
        let isIncreased = crypto.percentChange1Year > 0
        onNeedsToUpdate?(title, price, percentageChange, marketCap, circulatingSupplyValue, isIncreased)
    }
}
