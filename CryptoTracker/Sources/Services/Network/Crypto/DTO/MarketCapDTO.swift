//
//  MarketCapDTO.swift
//  CryptoTracker
//
//  Created by User on 12.03.2025.
//

import Foundation

struct MarketCapDTO: Decodable {
    let capitalization: Double?
    
    enum CodingKeys: String, CodingKey {
        case capitalization = "realized_marketcap_usd"
    }
}
