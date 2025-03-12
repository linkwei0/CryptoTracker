//
//  NetworkService+Crypto.swift
//  CryptoTracker
//
//  Created by Артём Бацанов on 11.03.2025.
//

import Foundation

extension NetworkService: CryptoNetworkProtocol {
    func getCrypto(with symbol: String, completion: @escaping (Result<CryptoDTO, NetworkError>) -> Void) {
        let request = CryptoEndpoint.getCrypto(symbol: symbol).request
        fetch(with: request, completion: completion)
    }
}
