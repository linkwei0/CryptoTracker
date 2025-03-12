//
//  HTTPStatusCode.swift
//  CryptoTracker
//
//  Created by Артём Бацанов on 11.03.2025.
//

import Foundation

enum HTTPStatusCode {
    static let okStatus = 200...299
    static let badRequest = 400...499
    static let internalServerError = 500...599
}
