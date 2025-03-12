//
//  MainTabBarController.swift
//  CryptoTracker
//
//  Created by User on 12.03.2025.
//

import UIKit

final class MainTabBarController: UITabBarController, NavigationBarHiding {
    private let coordinators: [Coordinator]
    
    // MARK: - Initializers
    
    init(coordinators: [Coordinator]) {
        self.coordinators = coordinators
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        viewControllers = coordinators.map { $0.navigationController }
        
        setupTabBarAppearance()
    }
    
    private func setupTabBarAppearance() {
        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .baseWhite
        appearance.shadowImage = nil
        appearance.shadowColor = nil
        
        appearance.stackedLayoutAppearance.selected.iconColor = .baseBlack
        appearance.stackedLayoutAppearance.selected.titleTextAttributes = [.foregroundColor: UIColor.baseBlack]
        
        if #available(iOS 15.0, *) {
            tabBar.scrollEdgeAppearance = appearance
            tabBar.standardAppearance = appearance
        } else {
            tabBar.standardAppearance = appearance
            tabBar.backgroundImage = UIImage()
            tabBar.shadowImage = UIImage()
        }
    }
}

