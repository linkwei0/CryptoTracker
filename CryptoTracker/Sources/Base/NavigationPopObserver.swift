//
//  NavigationPopObserver.swift
//  CryptoTracker
//
//  Created by Артём Бацанов on 11.03.2025.
//

import UIKit

class NavigationPopObserver {
    weak var observedViewController: UIViewController?
    weak var coordinator: Coordinator?
    
    init(observedViewController: UIViewController, coordinator: Coordinator) {
        self.observedViewController = observedViewController
        self.coordinator = coordinator
    }
    
    func didObservePop() {
        coordinator?.onDidFinish?()
    }
}
