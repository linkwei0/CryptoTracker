//
//  AuthInteractor.swift
//  CryptoTracker
//
//  Created by User on 12.03.2025.
//

import Foundation

class AuthInteractor {
    typealias Dependencies = HasDataStore
    
    private let dependecies: Dependencies
    
    init(dependecies: Dependencies) {
        self.dependecies = dependecies
    }
    
    func saveUser(user: User) {
        let userInfo = UserInfo(username: user.username, password: user.password)
        dependecies.dataService.userInfo = userInfo
    }
}
