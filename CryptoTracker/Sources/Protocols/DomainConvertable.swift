//
//  DomainConvertable.swift
//  CryptoTracker
//
//  Created by Артём Бацанов on 11.03.2025.
//

import Foundation

protocol DomainConvertable {
    associatedtype Model
    func asDomain() -> Model
}
