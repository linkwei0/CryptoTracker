//
//  LoadingDisplayable.swift
//  CryptoTracker
//
//  Created by User on 14.03.2025.
//

import UIKit

protocol LoadingDisplayable: AnyObject {
    var loaderView: UIActivityIndicatorView { get }
    func showLoader(in view: UIView)
    func hideLoader()
}

extension LoadingDisplayable {
    func showLoader(in view: UIView) {
        DispatchQueue.main.async {
            self.loaderView.startAnimating()
        }
    }
    
    func hideLoader() {
        DispatchQueue.main.async {
            self.loaderView.stopAnimating()
        }
    }
}

extension LoadingDisplayable where Self: UIViewController {
    func showLoader() {
        showLoader(in: self.view)
    }
}
