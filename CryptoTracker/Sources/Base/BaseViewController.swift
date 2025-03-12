//
//  ViewController.swift
//  CryptoTracker
//
//  Created by Артём Бацанов on 11.03.2025.
//

import UIKit
import SnapKit

class BaseViewController: UIViewController, NavigationBarHiding {
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    private func setup() {
        view.backgroundColor = .mainBackground
    }
}
