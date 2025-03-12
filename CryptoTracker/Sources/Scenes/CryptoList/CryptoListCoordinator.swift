//
//  CryptoListCoordinator.swift
//  CryptoTracker
//
//  Created by Артём Бацанов on 11.03.2025.
//

import Foundation

class CryptoListCoordinator: Coordinator {
    var childCoordinators: [Coordinator] = []
    var onDidFinish: (() -> Void)?
    
    let navigationController: NavigationController
    let appDependency: AppDependency

    required init(navigationController: NavigationController, appDependency: AppDependency) {
        self.navigationController = navigationController
        self.appDependency = appDependency
    }
        
    func start(animated: Bool) {
        showCryptoListScreen(animated: animated)
    }
    
    private func showCryptoListScreen(animated: Bool) {
        let interactor = CryptoListInteractor(dependencies: appDependency)
        let viewModel = CryptoListViewModel(interactor: interactor)
        viewModel.delegate = self
        let viewController = CryptoListViewController(viewModel: viewModel)
        addPopObserver(for: viewController)
        navigationController.pushViewController(viewController, animated: animated)
    }
}

// MARK: - CryptoListViewModelDelegate
extension CryptoListCoordinator: CryptoListViewModelDelegate {
    func viewModelDidRequestToShowDetails(_ viewModel: CryptoListViewModel, for crypto: Crypto) {
        let configuration = CryptoDetailsConfiguration(crypto: crypto)
        show(CryptoDetailsCoordinator.self, configuration: configuration, animated: true)
    }
}
