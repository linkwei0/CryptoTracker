//
//  SettingsCoordinator.swift
//  CryptoTracker
//
//  Created by User on 12.03.2025.
//

import Foundation

class SettingsCoordinator: Coordinator {
    var childCoordinators: [Coordinator] = []
    var onDidFinish: (() -> Void)?
    
    let navigationController: NavigationController
    let appDependency: AppDependency

    required init(navigationController: NavigationController, appDependency: AppDependency) {
        self.navigationController = navigationController
        self.appDependency = appDependency
    }
    
    func start(animated: Bool) {
        showSettingsScreen(animated: animated)
    }
    
    private func showSettingsScreen(animated: Bool) {
        let viewModel = SettingsViewModel()
        let viewController = SettingsViewController(viewModel: viewModel)
        addPopObserver(for: viewController)
        navigationController.pushViewController(viewController, animated: animated)
    }
}
