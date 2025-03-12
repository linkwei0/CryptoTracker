//
//  CryptoProtocols.swift
//  CryptoTracker
//
//  Created by Артём Бацанов on 11.03.2025.
//

import Foundation

protocol CryptoNetworkProtocol {
    func getCrypto(with symbol: String, completion: @escaping (Result<CryptoDTO, NetworkError>) -> Void)
}
