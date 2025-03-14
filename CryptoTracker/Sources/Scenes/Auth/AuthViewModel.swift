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

class AuthViewModel: AlertConfigurable {
    // MARK: - Properties
    var alertComponents: AlertComponents {
        return AlertComponents(
            title: "Ошибка ввода",
            message: "Логин и пароль должны содержать от 4 до 12 символов.",
            actions: [
                AlertActionComponent(title: "Повторить", style: .default) { _ in
                    print("Попробовать снова")
                },
                AlertActionComponent(title: "Очистить", style: .destructive) { _ in
                    self.selectCancel()
                }
            ]
        )
    }
    
    weak var delegate: AuthViewModelDelegate?
    
    var onNeedsToShowAlert: ((AlertComponents) -> Void)?
    var onNeedsToClearTextFields: (() -> Void)?
    
    private var username: String = "1234"
    private var password: String = "1234"
    
    private let interactor: AuthInteractor
    
    init(interactor: AuthInteractor) {
        self.interactor = interactor
    }
    
    // MARK: - Public methods
    func setText(_ text: String?, type: InputFieldType) {
        guard let text = text else { return }
        
        switch type {
        case .username:
            username = text
        case .password:
            password = text
        }
    }
    
    func getText(for type: InputFieldType) -> String {
        switch type {
        case .username:
            return username
        case .password:
            return password
        }
    }
    
    func didTapLogin() {
        if !textIsCorrect(username) || !textIsCorrect(password) {
            onNeedsToShowAlert?(alertComponents)
            return
        }
        let user = User(username: username, password: password)
        interactor.saveUser(user: user)
        delegate?.viewModelDidRequestToShowCryptoListScreen(self)
    }
        
    func selectRepeat() {}
    
    func selectCancel() {
        onNeedsToClearTextFields?()
    }
    
    // MARK: - Private methods
    private func textIsCorrect(_ text: String?) -> Bool {
        guard let text = text else { return false }
        return !text.isEmpty && text.count >= 4 && text.count < 12
    }
}
