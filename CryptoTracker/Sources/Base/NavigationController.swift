//
//  NavigationController.swift
//  CryptoTracker
//
//  Created by Артём Бацанов on 11.03.2025.
//

import UIKit

class NavigationController: UINavigationController {
    private var popObservers: [NavigationPopObserver] = []
    
    init() {
        super.init(nibName: nil, bundle: nil)
        configureDefaultNavigationBarAppearance()
        delegate = self
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func configureDefaultNavigationBarAppearance() {
        let titleAttributes: [NSAttributedString.Key: Any] = [.foregroundColor: UIColor.baseBlack,
                                                              .font: UIFont.appRegular ?? UIFont.systemFont(ofSize: 16)]
        
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = .mainBackground
        appearance.shadowColor = .clear
        appearance.shadowImage = UIImage()
        appearance.titleTextAttributes = titleAttributes
        navigationBar.standardAppearance = appearance
        navigationBar.scrollEdgeAppearance = appearance
        
        navigationBar.barTintColor = .baseWhite
        navigationBar.isTranslucent = false
        navigationBar.tintColor = .accent
        navigationBar.titleTextAttributes = titleAttributes
        navigationBar.shadowImage = UIImage()
    }
    
    func addPopObserver(for viewController: UIViewController, coordinator: Coordinator) {
        let observer = NavigationPopObserver(observedViewController: viewController, coordinator: coordinator)
        popObservers.append(observer)
    }
    
    func removeAllPopObservers() {
        popObservers.removeAll()
    }
}

// MARK: - UINavigationControllerDelegate
extension NavigationController: UINavigationControllerDelegate {
    func navigationController(_ navigationController: UINavigationController,
                              willShow viewController: UIViewController, animated: Bool) {
        if viewController is NavigationBarHiding {
            navigationController.setNavigationBarHidden(true, animated: animated)
        } else {
            navigationController.setNavigationBarHidden(false, animated: animated)
        }
    }
    
    func navigationController(_ navigationController: UINavigationController,
                              didShow viewController: UIViewController, animated: Bool) {
        popObservers.forEach { observer in
            if let observedViewController = observer.observedViewController,
               !navigationController.viewControllers.contains(observedViewController) {
                observer.didObservePop()
                popObservers.removeAll { $0 === observer }
            }
        }
    }
}
