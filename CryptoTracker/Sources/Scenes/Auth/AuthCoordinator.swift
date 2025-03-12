//
//  AuthCoordinator.swift
//  CryptoTracker
//
//  Created by Артём Бацанов on 11.03.2025.
//

import UIKit

protocol AuthCoordinatorDelegate: AnyObject {
    func authCoordinatorDidFinish(_ coordinator: AuthCoordinator)
}

final class AuthCoordinator: Coordinator {
    // MARK: - Properties
    weak var delegate: AuthCoordinatorDelegate?
    
    var childCoordinators: [Coordinator] = []
    var onDidFinish: (() -> Void)?
    
    let navigationController: NavigationController
    let appDependency: AppDependency

    // MARK: - Init
    init(navigationController: NavigationController, appDependency: AppDependency) {
        self.navigationController = navigationController
        self.appDependency = appDependency
    }
    
    // MARK: - Public methods
    func start(animated: Bool) {
        showAuthScreen(animated: animated)
    }
    
    // MARK: - Private methods
    private func showAuthScreen(animated: Bool) {
        let interactor = AuthInteractor(dependecies: appDependency)
        let viewModel = AuthViewModel(interactor: interactor)
        viewModel.delegate = self
        let viewController = AuthViewController(viewModel: viewModel)
        addPopObserver(for: viewController)
        navigationController.pushViewController(viewController, animated: animated)
    }
}

// MARK: - AuthViewModelDelegate
extension AuthCoordinator: AuthViewModelDelegate {
    func viewModelDidRequestToShowCryptoListScreen(_ viewModel: AuthViewModel) {
        delegate?.authCoordinatorDidFinish(self)
    }
}
