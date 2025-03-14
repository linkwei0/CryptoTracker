//
//  AuthViewController.swift
//  CryptoTracker
//
//  Created by Артём Бацанов on 11.03.2025.
//

import UIKit

class AuthViewController: BaseViewController, AlertPresentable {
    // MARK: - Properties
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    private let mainImageView = UIImageView()
    private let usernameTextField = InputFieldView(type: .username)
    private let passwordTextField = InputFieldView(type: .password)
    private let loginButton = UIButton()
    
    private let viewModel: AuthViewModel
    
    // MARK: - Init
    init(viewModel: AuthViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        bindToViewModel()
        setupKeyboardNotifications()
    }
    
    // MARK: - Actions
    @objc private func didTapLogin() {
        viewModel.didTapLogin()
    }
    
    @objc private func keyboardWillShow(notification: NSNotification) {
        guard let keyboardFrame = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else { return }
        
        let bottomInset = keyboardFrame.height
        scrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: bottomInset, right: 0)
        scrollView.scrollIndicatorInsets = scrollView.contentInset
    }
    
    @objc private func keyboardWillHide() {
        scrollView.contentInset = .zero
        scrollView.scrollIndicatorInsets = .zero
    }
    
    // MARK: - Setup
    private func setup() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        contentView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.width.equalToSuperview()
        }
        
        setupMainImage()
        setupUsernameTextField()
        setupPasswordTextField()
        setupLoginButton()
    }
    
    private func setupMainImage() {
        contentView.addSubview(mainImageView)
        mainImageView.image = UIImage.welcomeAuth
        mainImageView.contentMode = .scaleAspectFit
        mainImageView.clipsToBounds = true
        mainImageView.snp.makeConstraints { make in
            make.top.equalTo(contentView.safeAreaLayoutGuide)
            make.centerX.equalToSuperview()
            make.width.height.equalTo(287)
        }
    }
    
    private func setupUsernameTextField() {
        contentView.addSubview(usernameTextField)
        usernameTextField.snp.makeConstraints { make in
            make.top.equalTo(mainImageView.snp.bottom).offset(120)
            make.left.right.equalToSuperview().inset(24)
            make.height.equalTo(55)
        }
        usernameTextField.configure(with: viewModel)
    }
    
    private func setupPasswordTextField() {
        contentView.addSubview(passwordTextField)
        passwordTextField.snp.makeConstraints { make in
            make.top.equalTo(usernameTextField.snp.bottom).offset(20)
            make.left.right.equalToSuperview().inset(24)
            make.height.equalTo(55)
        }
        passwordTextField.configure(with: viewModel)
    }
    
    private func setupLoginButton() {
        contentView.addSubview(loginButton)
        loginButton.setTitle("Login", for: .normal)
        loginButton.setTitleColor(.white, for: .normal)
        loginButton.titleLabel?.font = UIFont.appBold
        loginButton.backgroundColor = .accentBtn
        loginButton.layer.cornerRadius = 55 / 2
        loginButton.addShadow()
        loginButton.addTarget(self, action: #selector(didTapLogin), for: .touchUpInside)
        loginButton.snp.makeConstraints { make in
            make.top.equalTo(passwordTextField.snp.bottom).offset(30)
            make.left.right.equalToSuperview().inset(24)
            make.height.equalTo(55)
            make.bottom.equalTo(contentView).offset(-20)
        }
    }
    
    // MARK: - Keyboard Handling
    private func setupKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    // MARK: - Bindable
    private func bindToViewModel() {
        viewModel.onNeedsToShowAlert = { [weak self] alertComponents in
            self?.presentAlert(alertComponents: alertComponents)
        }
        viewModel.onNeedsToClearTextFields = { [weak self] in
            self?.usernameTextField.clear()
            self?.passwordTextField.clear()
        }
    }
}
