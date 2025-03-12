//
//  ViewStateHandleable.swift
//  CryptoTracker
//
//  Created by User on 12.03.2025.
//

import Foundation

protocol ViewStateHandleable {
    func handleableResult<T>(_ entities: [T]) -> ViewState<T>
}

extension ViewStateHandleable {
    func handleableResult<T>(_ entities: [T]) -> ViewState<T> {
        return .populated(entities)
    }
}
