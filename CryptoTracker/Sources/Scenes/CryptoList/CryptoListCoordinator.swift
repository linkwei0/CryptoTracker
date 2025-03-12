//
//  CryptoListCoordinator.swift
//  CryptoTracker
//
//  Created by Артём Бацанов on 11.03.2025.
//

import UIKit

protocol CryptoListCoordinatorDelegate: AnyObject {
    func coordinatorDidFinish(_ coordinator: CryptoListCoordinator)
}

final class CryptoListCoordinator: Coordinator {
    weak var delegate: CryptoListCoordinatorDelegate?
    
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
        let coordinator = show(CryptoDetailsCoordinator.self, configuration: configuration, animated: true)
        coordinator.delegate = self
    }
    
    func viewModelDidRequestToShowAuth(_ viewModel: CryptoListViewModel) {
        delegate?.coordinatorDidFinish(self)
        onDidFinish?()
    }
}

// MARK: - CryptoDetailsCoordinatorDelegate
extension CryptoListCoordinator: CryptoDetailsCoordinatorDelegate {
    func coordinatorDidFinish(_ coordinator: CryptoDetailsCoordinator) {
        delegate?.coordinatorDidFinish(self)
        onDidFinish?()
    }
}
