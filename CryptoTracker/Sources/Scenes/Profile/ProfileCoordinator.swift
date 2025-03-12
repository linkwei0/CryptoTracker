//
//  ProfileCoordinator.swift
//  CryptoTracker
//
//  Created by User on 12.03.2025.
//

import Foundation

class ProfileCoordinator: Coordinator {
    var childCoordinators: [Coordinator] = []
    var onDidFinish: (() -> Void)?
    
    let navigationController: NavigationController
    let appDependency: AppDependency

    required init(navigationController: NavigationController, appDependency: AppDependency) {
        self.navigationController = navigationController
        self.appDependency = appDependency
    }
    
    func start(animated: Bool) {
        showProfileScreen(animated: animated)
    }
    
    private func showProfileScreen(animated: Bool) {
        let viewModel = ProfileViewModel()
        let viewController = ProfileViewController(viewModel: viewModel)
        addPopObserver(for: viewController)
        navigationController.pushViewController(viewController, animated: animated)
    }
}
