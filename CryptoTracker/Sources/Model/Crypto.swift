//
//  Crypto.swift
//  CryptoTracker
//
//  Created by Артём Бацанов on 11.03.2025.
//

import Foundation

struct Crypto {
    let id: String
    let symbol: String
    let name: String
    let price: Double
    let price24H: Double
    let supply: Double
    let marketCap: Double
    let percentChange24Hours: Double
    let percentChange1Week: Double
    let percentChange1Year: Double
    let type: CryptoType
}
