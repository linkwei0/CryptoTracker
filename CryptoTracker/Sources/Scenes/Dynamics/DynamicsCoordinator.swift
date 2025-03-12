//
//  DynamicsCoordinator.swift
//  CryptoTracker
//
//  Created by User on 12.03.2025.
//

import Foundation

class DynamicsCoordinator: Coordinator {
    var childCoordinators: [Coordinator] = []
    var onDidFinish: (() -> Void)?
    
    let navigationController: NavigationController
    let appDependency: AppDependency

    required init(navigationController: NavigationController, appDependency: AppDependency) {
        self.navigationController = navigationController
        self.appDependency = appDependency
    }
    
    func start(animated: Bool) {
        showDynamicsScreen(animated: animated)
    }
    
    private func showDynamicsScreen(animated: Bool) {
        let viewModel = DynamicsViewModel()
        let viewController = DynamicsViewController(viewModel: viewModel)
        addPopObserver(for: viewController)
        navigationController.pushViewController(viewController, animated: animated)
    }
}
