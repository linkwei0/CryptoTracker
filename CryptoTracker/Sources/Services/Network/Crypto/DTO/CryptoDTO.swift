//
//  CryptoDTO.swift
//  CryptoTracker
//
//  Created by Артём Бацанов on 11.03.2025.
//

import Foundation

struct CryptoDTO: Decodable {
    let data: CryptoDataDTO
}

// MARK: - DomainConvertable
extension CryptoDTO: DomainConvertable {
    func asDomain() -> Crypto {
        return .init(id: data.id, symbol: data.symbol, name: data.name, price: data.marketData.priceUSD,
                     price24H: data.marketData.percentChange24H, supply: data.supplyActivity.supply1d ?? 0,
                     marketCap: data.marketcap.capitalization ?? 0, percentChange24Hours: data.marketData.percentChange24H,
                     percentChange1Week: data.roiData.percentChange1Week ?? 0,
                     percentChange1Year: data.roiData.percentChange1Year ?? 0, type: CryptoType(rawValue: data.symbol) ?? .others)
    }
}
