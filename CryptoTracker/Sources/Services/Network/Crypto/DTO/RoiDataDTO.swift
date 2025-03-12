//
//  RoiDataDTO.swift
//  CryptoTracker
//
//  Created by User on 12.03.2025.
//

import Foundation

struct RoiDataDTO: Decodable {
    let percentChange1Week: Double?
    let percentChange1Year: Double?
    
    enum CodingKeys: String, CodingKey {
        case percentChange1Week = "percent_change_last_1_week"
        case percentChange1Year = "percent_change_eth_last_1_year"
    }
}
