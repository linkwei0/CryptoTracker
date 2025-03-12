//
//  DataStoreService.swift
//  CryptoTracker
//
//  Created by User on 12.03.2025.
//

import Foundation

final class DataStoreService: DataStoreProtocol {
    private struct UserDefaultsKeys {
        static let userInfo = "userInfo"
    }
    
    private let userDefaults = UserDefaults.standard
    
    var userInfo: UserInfo? {
        get {
            guard let data = userDefaults.data(forKey: UserDefaultsKeys.userInfo) else { return nil }
            return try? JSONDecoder().decode(UserInfo.self, from: data)
        }
        set {
            if let newValue = newValue {
                if let data = try? JSONEncoder().encode(newValue) {
                    userDefaults.set(data, forKey: UserDefaultsKeys.userInfo)
                }
            } else {
                userDefaults.removeObject(forKey: UserDefaultsKeys.userInfo)
            }
        }
    }
}
