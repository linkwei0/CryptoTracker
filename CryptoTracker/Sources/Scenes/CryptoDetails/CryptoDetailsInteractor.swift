//
//  CryptoDetailsInteractor.swift
//  CryptoTracker
//
//  Created by User on 12.03.2025.
//

import Foundation

final class CryptoDetailsInteractor {
    typealias Dependencies = HasDataStore
    
    private let dependencies: Dependencies
    
    init(dependencies: Dependencies) {
        self.dependencies = dependencies
    }
    
    func signOut() {
        dependencies.dataService.userInfo = nil
    }
}
