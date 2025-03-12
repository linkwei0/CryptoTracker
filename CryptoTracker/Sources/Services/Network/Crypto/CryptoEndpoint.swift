//
//  CryptoEndpoint.swift
//  CryptoTracker
//
//  Created by Артём Бацанов on 11.03.2025.
//

import Foundation

enum CryptoEndpoint {
    case getCrypto(symbol: String)
}

// MARK: - Endpoint
extension CryptoEndpoint: Endpoint {
    var path: String {
        switch self {
        case .getCrypto(let symbol):
            return "/assets/\(symbol)/metrics"
        }
    }
    
    var headers: [String: String]? {
        return nil
    }
    
    var params: [String: Any]? {
        return nil
    }
    
    var method: HTTPMethod {
        return .get
    }
}
