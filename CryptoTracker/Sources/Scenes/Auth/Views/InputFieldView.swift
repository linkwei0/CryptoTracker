//
//  InputFieldView.swift
//  CryptoTracker
//
//  Created by Артём Бацанов on 11.03.2025.
//

import UIKit

class InputFieldView: UIView {
    // MARK: - Properties
    private let iconImageView = UIImageView()
    private let textField = UITextField()
    
    private let type: InputFieldType
    
    private var viewModel: AuthViewModel?
    
    // MARK: - Init
    init(type: InputFieldType) {
        self.type = type
        super.init(frame: .zero)
        
        backgroundColor = .baseWhite
        layer.cornerRadius = 27
        layer.masksToBounds = true
        
        iconImageView.image = type.icon
        textField.placeholder = type.placeholder
        textField.isSecureTextEntry = type.isSecure
        
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Configure
    func configure(with viewModel: AuthViewModel) {
        self.viewModel = viewModel
        
        textField.text = "1234"
        viewModel.setText("1234", type: type)
    }
    
    // MARK: - Actions
    @objc private func textFieldChange() {
        viewModel?.setText(textField.text, type: type)
    }
    
    @objc private func doneButtonTapped() {
        endEditing(true)
    }
    
    // MARK: - Setup
    private func setup() {
        setupIconImageView()
        setupTextField()
        setupContainer()
    }
    
    private func setupIconImageView() {
        addSubview(iconImageView)
        iconImageView.contentMode = .scaleAspectFit
        iconImageView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(15)
            make.centerY.equalToSuperview()
            make.width.height.equalTo(32)
        }
    }
    
    private func setupTextField() {
        addSubview(textField)
        textField.font = UIFont.appRegular
        textField.textColor = .darkGray
        textField.addTarget(self, action: #selector(textFieldChange), for: .editingChanged)
        textField.delegate = self
        textField.backgroundColor = .baseWhite
        textField.returnKeyType = .continue
        textField.snp.makeConstraints { make in
            make.left.equalTo(iconImageView.snp.right).offset(10)
            make.right.equalToSuperview().offset(-15)
            make.centerY.equalToSuperview()
            make.height.equalTo(40)
        }
        addDoneButtonTo(textField: textField)
    }
    
    private func setupContainer() {
        snp.makeConstraints { make in
            make.height.equalTo(55)
        }
    }
    
    // MARK: - Private methods
    private func addDoneButtonTo(textField: UITextField) {
        let toolbar: UIToolbar = UIToolbar(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 45))
        
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneButton = UIBarButtonItem(title: "Готово", style: .done, target: self, action: #selector(doneButtonTapped))
        
        let items = [flexSpace, doneButton]
        toolbar.items = items
        toolbar.sizeToFit()
        textField.inputAccessoryView = toolbar
    }
}

// MARK: - UITextFieldDelegate
extension InputFieldView: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

// MARK: - Enums
enum InputFieldType {
    case username
    case password
    
    var icon: UIImage {
        switch self {
        case .username:
            return .userIcon
        case .password:
            return .passwordLockIcon
        }
    }
    
    var placeholder: String {
        switch self {
        case .username:
            return "Username"
        case .password:
            return "Password"
        }
    }
    
    var isSecure: Bool {
        switch self {
        case .username:
            return false
        case .password:
            return true
        }
    }
}
