//
//  ViewState.swift
//  CryptoTracker
//
//  Created by User on 12.03.2025.
//

import Foundation

enum ViewState<Entity> {
    case loading
    case populated([Entity])
    
    var currentEntities: [Entity] {
        switch self {
        case .loading:
            return []
        case .populated(let entities):
            return entities
        }
    }
}
