//
//  LoginController.swift
//  bryng
//
//  Created by Florian Woelki on 18.04.19.
//  Copyright © 2019 bryng. All rights reserved.
//

import UIKit
import CoreData
import JGProgressHUD

class LoginController: UIViewController {
    
    let emailTextField: BryngTextField = {
        let tf = BryngTextField(padding: 24, height: 50)
        tf.placeholder = "Deine E-Mail"
        tf.keyboardType = .emailAddress
        tf.backgroundColor = .white
        tf.addTarget(self, action: #selector(handleTextChange), for: .editingChanged)
        return tf
    }()
    let passwordTextField: BryngTextField = {
        let tf = BryngTextField(padding: 24, height: 50)
        tf.placeholder = "Dein Passwort"
        tf.isSecureTextEntry = true
        tf.backgroundColor = .white
        tf.addTarget(self, action: #selector(handleTextChange), for: .editingChanged)
        return tf
    }()
    
    @objc private func handleTextChange(textField: UITextField) {
        if textField == emailTextField {
            loginViewModel.email = textField.text
        } else {
            loginViewModel.password = textField.text
        }
    }
    
    let loginButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("Login", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .heavy)
        btn.backgroundColor = .lightGray
        btn.setTitleColor(.gray, for: .disabled)
        btn.isEnabled = false
        btn.heightAnchor.constraint(equalToConstant: 44).isActive = true
        btn.layer.cornerRadius = 22
        btn.addTarget(self, action: #selector(handleLogin), for: .touchUpInside)
        return btn
    }()
    
    let goToRegisterButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("Registrieren", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .light)
        btn.addTarget(self, action: #selector(didTapOnRegister), for: .touchUpInside)
        return btn
    }()
    
    @objc private func didTapOnRegister() {
        navigationController?.popViewController(animated: true)
    }
    
    let loginHUD = JGProgressHUD(style: .dark)
    
    @objc private func handleLogin() {
        CoreDataManager.shared.updateLoginSession(isLoggedIn: true)
        
        dismiss(animated: true)
        // TOOD: Find fix for progress bar
        /*loginHUD.textLabel.text = "Du wirst eingeloggt!"
        loginHUD.show(in: view)
        loginHUD.dismiss(afterDelay: 2.5, animated: true)*/
        /*DispatchQueue.main.asyncAfter(deadline: .now() + 3) { [weak self] in
            self?.dismiss(animated: true)
         }*/
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupGradientLayer()
        setupLayout()
        setupNotificationObservers()
        setupTabGesture()
        setupRegistrationViewModelObserver()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self)
    }
    
    // MARK:- Private
    
    let loginViewModel = LoginViewModel()
    
    private func setupRegistrationViewModelObserver() {
        loginViewModel.isFormValidObserver = { [unowned self] (isFormValid) in
            self.loginButton.isEnabled = isFormValid
            if isFormValid {
                self.loginButton.backgroundColor = #colorLiteral(red: 0.8036853601, green: 0.2847245294, blue: 0.4008832808, alpha: 1)
                self.loginButton.setTitleColor(.white, for: .normal)
            } else {
                self.loginButton.backgroundColor = .lightGray
                self.loginButton.setTitleColor(.gray, for: .normal)
            }
        }
    }
    
    private func setupTabGesture() {
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTapDismiss)))
    }
    
    @objc private func handleTapDismiss() {
        self.view.endEditing(true)
    }
    
    private func setupNotificationObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc private func handleKeyboardHide() {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.view.transform = .identity
        }, completion: nil)
    }
    
    @objc private func handleKeyboardShow(notification: Notification) {
        guard let value = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return }
        
        let keyboardFrame = value.cgRectValue
        
        let bottomSpace = view.frame.height - stackView.frame.origin.y - stackView.frame.height
        
        let difference = keyboardFrame.height - bottomSpace
        self.view.transform = CGAffineTransform(translationX: 0, y: difference - 8)
    }
    
    lazy var stackView = VerticalStackView(arrangedSubviews: [
        emailTextField,
        passwordTextField,
        loginButton
        ], spacing: 8)
    
    private func setupLayout() {
        view.addSubview(stackView)
        stackView.anchor(top: nil, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: 0, left: 50, bottom: 0, right: 50))
        stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        view.addSubview(goToRegisterButton)
        goToRegisterButton.anchor(top: nil, leading: view.leadingAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, trailing: view.trailingAnchor)
    }
    
    private func setupGradientLayer() {
        let gradientLayer = CAGradientLayer()
        let topColor = #colorLiteral(red: 0.8036853601, green: 0.2847245294, blue: 0.4008832808, alpha: 1)
        let bottomColor = #colorLiteral(red: 1, green: 0.4363002704, blue: 0.3327765649, alpha: 1)
        gradientLayer.colors = [topColor.cgColor, bottomColor.cgColor]
        gradientLayer.locations = [0, 1]
        view.layer.addSublayer(gradientLayer)
        gradientLayer.frame = view.bounds
    }
    
}

