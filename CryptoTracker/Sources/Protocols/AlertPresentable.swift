//
//  AlertPresentable.swift
//  CryptoTracker
//
//  Created by User on 14.03.2025.
//

import UIKit

protocol AlertConfigurable {
    var alertComponents: AlertComponents { get }
}

protocol AlertPresentable where Self: UIViewController {
    func presentAlert(alertComponents: AlertComponents)
}

extension AlertPresentable {
    func presentAlert(alertComponents: AlertComponents) {
        let alert = UIAlertController(
            title: alertComponents.title,
            message: alertComponents.message,
            preferredStyle: .alert
        )
        alertComponents.actions.forEach { alert.addAction($0) }
        present(alert, animated: true, completion: alertComponents.completion)
    }
}

// MARK: - Structs
struct AlertActionComponent {
    var title: String
    var style: UIAlertAction.Style
    var handler: ((UIAlertAction) -> Void)?
    
    init(title: String, style: UIAlertAction.Style = .default,
         handler: ((UIAlertAction) -> Void)? = nil) {
        self.title = title
        self.style = style
        self.handler = handler
    }
}

struct AlertComponents {
    var title: String?
    var message: String?
    var actions: [UIAlertAction]
    var completion: (() -> Void)?
    
    init(title: String?, message: String? = nil, actions: [AlertActionComponent],
         completion: (() -> Void)? = nil) {
        self.title = title
        self.message = message
        self.completion = completion
        self.actions = actions.map { UIAlertAction(title: $0.title, style: $0.style, handler: $0.handler) }
    }
}
