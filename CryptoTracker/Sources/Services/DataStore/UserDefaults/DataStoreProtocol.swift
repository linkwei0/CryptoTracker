//
//  DataStoreProtocol.swift
//  CryptoTracker
//
//  Created by User on 12.03.2025.
//

import Foundation

protocol DataStoreProtocol: AnyObject {
    var userInfo: UserInfo? { get set }
}
