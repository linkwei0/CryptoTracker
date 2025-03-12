//
//  AppDependency.swift
//  CryptoTracker
//
//  Created by Артём Бацанов on 11.03.2025.
//

import Foundation

protocol HasCryptoService {
    var cryptoSerivce: CryptoNetworkProtocol { get }
}

protocol HasDataStore {
    var dataService: DataStoreProtocol { get }
}

final class AppDependency {
    private let networkService: NetworkService
    private let dataStore: DataStoreProtocol
    
    init() {
        self.networkService = NetworkService()
        self.dataStore = DataStoreService()
    }
}

// MARK: - HasDataStore
extension AppDependency: HasDataStore {
    var dataService: DataStoreProtocol {
        return dataStore
    }
}

// MARK: - HasCryptoService
extension AppDependency: HasCryptoService {
    var cryptoSerivce: CryptoNetworkProtocol {
        return networkService
    }
}
