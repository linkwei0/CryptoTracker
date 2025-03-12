//
//  SupplyActivityDTO.swift
//  CryptoTracker
//
//  Created by User on 12.03.2025.
//

import Foundation

struct SupplyActivityDTO: Decodable {
    let supply1d: Double?
    
    enum CodingKeys: String, CodingKey {
        case supply1d = "supply_active_1d"
    }
}
