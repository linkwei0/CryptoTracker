//
//  WalletCoordinator.swift
//  CryptoTracker
//
//  Created by User on 12.03.2025.
//

import Foundation

class WalletCoordinator: Coordinator {
    var childCoordinators: [Coordinator] = []
    var onDidFinish: (() -> Void)?
    
    let navigationController: NavigationController
    let appDependency: AppDependency

    required init(navigationController: NavigationController, appDependency: AppDependency) {
        self.navigationController = navigationController
        self.appDependency = appDependency
    }
    
    func start(animated: Bool) {
        showWalletScreen(animated: animated)
    }
    
    private func showWalletScreen(animated: Bool) {
        let viewModel = WalletViewModel()
        let viewController = WalletViewController(viewModel: viewModel)
        addPopObserver(for: viewController)
        navigationController.pushViewController(viewController, animated: animated)
    }
}
