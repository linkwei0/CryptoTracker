//
//  WalletViewController.swift
//  CryptoTracker
//
//  Created by User on 12.03.2025.
//

import Foundation

class WalletViewController: BaseViewController {
    private let viewModel: WalletViewModel
    
    init(viewModel: WalletViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .green
    }
}
