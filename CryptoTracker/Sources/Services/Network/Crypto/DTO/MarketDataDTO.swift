//
//  MarketDataDTO.swift
//  CryptoTracker
//
//  Created by User on 12.03.2025.
//

import Foundation

struct CryptoDataDTO: Decodable {
    let id: String
    let name: String
    let symbol: String
    let marketData: MarketDataDTO
    let supplyActivity: SupplyActivityDTO
    let marketcap: MarketCapDTO
    let roiData: RoiDataDTO
    
    enum CodingKeys: String, CodingKey {
        case id, name, symbol, marketcap
        case marketData = "market_data"
        case supplyActivity = "supply_activity"
        case roiData = "roi_data"
    }
}

struct MarketDataDTO: Decodable {
    let priceUSD: Double
    let percentChange24H: Double
    
    enum CodingKeys: String, CodingKey {
        case priceUSD = "price_usd"
        case percentChange24H = "percent_change_usd_last_24_hours"
    }
}
