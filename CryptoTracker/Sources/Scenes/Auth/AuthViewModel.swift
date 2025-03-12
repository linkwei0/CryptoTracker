//
//  AuthViewModel.swift
//  CryptoTracker
//
//  Created by Артём Бацанов on 11.03.2025.
//

import Foundation

protocol AuthViewModelDelegate: AnyObject {
    func viewModelDidRequestToShowCryptoListScreen(_ viewModel: AuthViewModel)
}

class AuthViewModel {
    // MARK: - Properties
    weak var delegate: AuthViewModelDelegate?
    
    private var username: String?
    private var password: String?
    
    private let interactor: AuthInteractor
    
    init(interactor: AuthInteractor) {
        self.interactor = interactor
    }
    
    // MARK: - Public methods
    func setText(_ text: String?, type: InputFieldType) {
        switch type {
        case .username:
            username = text
        case .password:
            password = text
        }
    }
    
    func didTapLogin() {
        if username.isEmptyOrNil || password.isEmptyOrNil { return }
        let user = User(username: username ?? "", password: password ?? "")
        interactor.saveUser(user: user)
        delegate?.viewModelDidRequestToShowCryptoListScreen(self)
    }
}
