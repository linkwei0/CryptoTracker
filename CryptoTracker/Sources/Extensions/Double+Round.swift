//
//  Double+Round.swift
//  CryptoTracker
//
//  Created by User on 12.03.2025.
//

import Foundation

extension Double {
    func toRounadableString() -> String {
        return String(format: "%.4f", self).replacingOccurrences(of: ",", with: ".")
    }
}
