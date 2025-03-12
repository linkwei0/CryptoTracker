//
//  ConfigurableCoordinator.swift
//  CryptoTracker
//
//  Created by Артём Бацанов on 11.03.2025.
//

import Foundation

protocol ConfigurableCoordinator: Coordinator {
    associatedtype Configuration
    
    init(navigationController: NavigationController,
         appDependency: AppDependency, configuration: Configuration)
}

extension ConfigurableCoordinator {
    init(navigationController: NavigationController, appDependency: AppDependency) {
        fatalError("Use init with configuration for this coordinator")
    }
}
