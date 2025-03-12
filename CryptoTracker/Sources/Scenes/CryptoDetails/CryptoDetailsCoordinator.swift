//
//  CryptoDetailsCoordinator.swift
//  CryptoTracker
//
//  Created by User on 12.03.2025.
//

import Foundation

struct CryptoDetailsConfiguration {
    let crypto: Crypto
}

protocol CryptoDetailsCoordinatorDelegate: AnyObject {
    func coordinatorDidFinish(_ coordinator: CryptoDetailsCoordinator)
}

final class CryptoDetailsCoordinator: ConfigurableCoordinator {
    typealias Configuration = CryptoDetailsConfiguration
    
    weak var delegate: CryptoDetailsCoordinatorDelegate?
    
    var childCoordinators: [Coordinator] = []
    var onDidFinish: (() -> Void)?
    
    let navigationController: NavigationController
    let appDependency: AppDependency
    private let configuration: Configuration
    
    required init(navigationController: NavigationController, appDependency: AppDependency, configuration: Configuration) {
        self.navigationController = navigationController
        self.appDependency = appDependency
        self.configuration = configuration
    }
    
    func start(animated: Bool) {
        showCryptoDetailsScreen(animated: animated)
    }
    
    private func showCryptoDetailsScreen(animated: Bool) {
        let interactor = CryptoDetailsInteractor(dependencies: appDependency)
        let viewModel = CryptoDetailsViewModel(crypto: configuration.crypto, interactor: interactor)
        viewModel.delegate = self
        let viewController = CryptoDetailsViewController(viewModel: viewModel)
        addPopObserver(for: viewController)
        navigationController.pushViewController(viewController, animated: animated)
    }
}

// MARK: - CryptoDetailsViewModelDelegate
extension CryptoDetailsCoordinator: CryptoDetailsViewModelDelegate {
    func viewModelDidRequestToBack(_ viewModel: CryptoDetailsViewModel) {
        navigationController.popViewController(animated: true)
    }
    
    func viewModelDidRequestToSignOut(_ viewModel: CryptoDetailsViewModel) {
        delegate?.coordinatorDidFinish(self)
        onDidFinish?()
    }
}
