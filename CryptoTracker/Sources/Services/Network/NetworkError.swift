//
//  NetworkError.swift
//  CryptoTracker
//
//  Created by Артём Бацанов on 11.03.2025.
//

import Foundation

enum NetworkError: LocalizedError {
    case clientError
    case serverError
    case unknownError
    case errorInUrl
    case errorDecoding
    
    var errorDescription: String? {
        switch self {
        case .errorDecoding:
            return "Failed to decode data"
        case .serverError:
            return "Server error"
        case .errorInUrl:
            return "Error in URL"
        case .clientError:
            return "Failed in client"
        case .unknownError:
            return "Unknown error"
        }
    }
}
