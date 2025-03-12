//
//  Optional+String.swift
//  CryptoTracker
//
//  Created by User on 12.03.2025.
//

import Foundation

extension Optional where Wrapped == String {
    var isEmptyOrNil: Bool {
        return self?.isEmpty ?? true
    }
}
