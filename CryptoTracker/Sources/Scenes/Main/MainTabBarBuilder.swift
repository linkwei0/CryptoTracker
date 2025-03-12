//
//  MainTabBarBuilder.swift
//  CryptoTracker
//
//  Created by User on 12.03.2025.
//

import UIKit

final class MainTabBarBuilder {
    class func buildViewCoordinators(appDependency: AppDependency, delegate: MainCoordinator) -> [Coordinator] {
        let cryptoListNavController = createNavigationController(image: .homeIcon)
        let cryptoListCoordinator = CryptoListCoordinator(navigationController: cryptoListNavController, appDependency: appDependency)
        cryptoListCoordinator.delegate = delegate
        cryptoListCoordinator.start(animated: false)
        
        let dynamicsNavController = createNavigationController(image: .dynamicsIcon)
        let dynamicsCoordinator = DynamicsCoordinator(navigationController: dynamicsNavController, appDependency: appDependency)
        dynamicsCoordinator.start(animated: false)
        
        let walletNavController = createNavigationController(image: .walletIcon)
        let walletCoordinator = WalletCoordinator(navigationController: walletNavController, appDependency: appDependency)
        walletCoordinator.start(animated: false)
        
        let settingsNavController = createNavigationController(image: .settingsIcon)
        let settingsCoordinator = SettingsCoordinator(navigationController: settingsNavController, appDependency: appDependency)
        settingsCoordinator.start(animated: false)
        
        let profileNavController = createNavigationController(image: .profileIcon)
        let profileCoordinator = ProfileCoordinator(navigationController: profileNavController, appDependency: appDependency)
        profileCoordinator.start(animated: false)
        
        return [
            cryptoListCoordinator,
            dynamicsCoordinator,
            walletCoordinator,
            settingsCoordinator,
            profileCoordinator
        ]
    }
    
    class func createNavigationController(image: UIImage) -> NavigationController {
        let navController = NavigationController()
        navController.tabBarItem.image = image
        
        return navController
    }
}
