//
//  MainCoordinator.swift
//  CryptoTracker
//
//  Created by Артём Бацанов on 11.03.2025.
//

import UIKit

final class MainCoordinator: Coordinator {
    var childCoordinators: [Coordinator] = []
    var onDidFinish: (() -> Void)?
    
    let navigationController: NavigationController
    let appDependency: AppDependency
    
    init(navigationController: NavigationController, appDependency: AppDependency = AppDependency()) {
        self.navigationController = navigationController
        self.appDependency = appDependency
    }
    
    func start(animated: Bool) {
        if appDependency.dataService.userInfo == nil {
            showAuthScreen(animated: animated)
        } else {
            showTabBarScreen(animated: animated)
        }
    }
    
    private func showAuthScreen(animated: Bool) {
        let coordinator = show(AuthCoordinator.self, animated: animated)
        coordinator.delegate = self
    }
    
    private func showTabBarScreen(animated: Bool) {
        let coordinators = MainTabBarBuilder.buildViewCoordinators(appDependency: appDependency, delegate: self)
        let tabBarController = MainTabBarController(coordinators: coordinators)
        addPopObserver(for: tabBarController)
        navigationController.setViewControllers([tabBarController], animated: animated)
    }
    
    private func resetCoordinators() {
        navigationController.dismiss(animated: false, completion: nil)
        navigationController.setViewControllers([], animated: false)
        navigationController.removeAllPopObservers()
        childCoordinators.removeAll()
        
        if let window = UIApplication.shared.connectedScenes
            .filter({ $0.activationState == .foregroundActive })
            .map({ $0 as? UIWindowScene })
            .compactMap({ $0 })
            .first?.windows
            .first(where: { $0.isKeyWindow }) {
            changeRootViewController(of: window, to: navigationController)
        }
        start(animated: false)
    }
    
    private func changeRootViewController(of window: UIWindow,
                                          to viewController: UIViewController,
                                          animationDuration: TimeInterval = 0.5) {
        let animations = {
            UIView.performWithoutAnimation {
                window.rootViewController = self.navigationController
            }
        }
        UIView.transition(with: window, duration: animationDuration, options: .transitionFlipFromLeft,
                          animations: animations, completion: nil)
    }
}

// MARK: - AuthCoordinatorDelegate
extension MainCoordinator: AuthCoordinatorDelegate {
    func authCoordinatorDidFinish(_ coordinator: AuthCoordinator) {
        resetCoordinators()
    }
}

// MARK: - CryptoListCoordinatorDelegate
extension MainCoordinator: CryptoListCoordinatorDelegate {
    func coordinatorDidFinish(_ coordinator: CryptoListCoordinator) {
        resetCoordinators()
    }
}
