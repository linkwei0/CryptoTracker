//
//  CryptoListInteractor.swift
//  CryptoTracker
//
//  Created by Артём Бацанов on 11.03.2025.
//

import Foundation

class CryptoListInteractor {
    typealias Dependencies = HasCryptoService
    
    private let dependencies: Dependencies
    
    init(dependencies: Dependencies) {
        self.dependencies = dependencies
    }
    
    func loadData(symbols: [String], completion: @escaping ([Crypto]) -> Void) {
        let dispatchGroup = DispatchGroup()
        var cryptos: [Crypto] = []
        let queue = DispatchQueue(label: "crypto.sync.queue")
        
        for symbol in symbols {
            dispatchGroup.enter()
            
            dependencies.cryptoSerivce.getCrypto(with: symbol) { result in
                switch result {
                case .success(let cryptoDTO):
                    let crypto = cryptoDTO.asDomain()
                    queue.sync { cryptos.append(crypto) }
                case .failure(let error):
                    print("Ошибка загрузки \(symbol): \(error)")
                }
                dispatchGroup.leave()
            }
        }
        
        dispatchGroup.notify(queue: .main) {
            completion(cryptos)
        }
    }
}

