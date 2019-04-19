//
//  RegistrationController.swift
//  bryng
//
//  Created by Florian Woelki on 14.04.19.
//  Copyright © 2019 bryng. All rights reserved.
//

import UIKit
import JGProgressHUD

extension RegistrationController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[.originalImage] as? UIImage
        self.selectPhotoButton.setImage(image?.withRenderingMode(.alwaysOriginal), for: .normal)
        dismiss(animated: true)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true)
    }
    
}

class RegistrationController: UIViewController {
    
    // UI Components
    let selectPhotoButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Dein Foto", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 32)
        button.backgroundColor = .white
        button.setTitleColor(.black, for: .normal)
        button.heightAnchor.constraint(equalToConstant: 275).isActive = true
        button.layer.cornerRadius = 16
        button.addTarget(self, action: #selector(handleSelectPhoto), for: .touchUpInside)
        button.imageView?.contentMode = .scaleAspectFill
        button.clipsToBounds = true
        return button
    }()
    
    @objc fileprivate func handleSelectPhoto() {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        present(imagePickerController, animated: true)
    }
    
    let nameTextField: BryngTextField = {
        let tf = BryngTextField(padding: 24, height: 50)
        tf.placeholder = "Dein Name"
        tf.backgroundColor = .white
        tf.addTarget(self, action: #selector(handleTextChange), for: .editingChanged)
        tf.autocapitalizationType = .none
        return tf
    }()
    let emailTextField: BryngTextField = {
        let tf = BryngTextField(padding: 24, height: 50)
        tf.placeholder = "Deine E-Mail"
        tf.keyboardType = .emailAddress
        tf.backgroundColor = .white
        tf.addTarget(self, action: #selector(handleTextChange), for: .editingChanged)
        tf.autocapitalizationType = .none
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
        if textField == nameTextField {
            registrationViewModel.name = textField.text
        } else if textField == emailTextField {
            registrationViewModel.email = textField.text
        } else {
            registrationViewModel.password = textField.text
        }
    }
    
    let registerButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("Registrieren", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .heavy)
        btn.backgroundColor = .lightGray
        btn.setTitleColor(.gray, for: .disabled)
        btn.isEnabled = false
        btn.heightAnchor.constraint(equalToConstant: 44).isActive = true
        btn.layer.cornerRadius = 22
        btn.addTarget(self, action: #selector(handleRegister), for: .touchUpInside)
        return btn
    }()
    
    let goToLoginButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("Einloggen", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .light)
        btn.addTarget(self, action: #selector(didTapOnLogin), for: .touchUpInside)
        return btn
    }()
    
    @objc private func didTapOnLogin() {
        let loginController = LoginController()
        navigationController?.pushViewController(loginController, animated: true)
    }
    
    let registrationHUD = JGProgressHUD(style: .dark)
    
    @objc private func handleRegister() {
        registrationHUD.textLabel.text = "Überprüfe..."
        registrationHUD.show(in: view)
        
        checkData { [weak self] (validated) in
            if validated {
                CoreDataManager.shared.updateLoginSession(isLoggedIn: true)
                
                self?.dismiss(animated: true)
            } else {
                print("Something went wrong! Please try again")
            }
            
            self?.registrationHUD.dismiss(animated: true)
        }
    }
    
    private func checkData(callback: @escaping (_ validated: Bool) -> Void) {
        if let fullname = nameTextField.text, let email = emailTextField.text, let password = passwordTextField.text {
            let registerMutation = RegisterMutation(fullname: fullname, email: email, password: password, username: fullname.trimmingCharacters(in: .whitespaces), phoneNumber: nil, age: nil, avatar: nil)
            
            GraphQL.shared.apollo.perform(mutation: registerMutation) { result, error in
                if let error = error {
                    print(error)
                    callback(false)
                    return
                }
                
                guard let register = result?.data?.createUser else {
                    callback(false)
                    return
                }
                
                print(register.token)
                callback(true)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupGradientLayer()
        setupLayout()
        setupTabGesture()
        setupRegistrationViewModelObserver()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setupNotificationObservers()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self)
    }
    
    // MARK:- Private
    
    let registrationViewModel = RegistrationViewModel()
    
    private func setupRegistrationViewModelObserver() {
        registrationViewModel.isFormValidObserver = { [unowned self] (isFormValid) in
            self.registerButton.isEnabled = isFormValid
            if isFormValid {
                self.registerButton.backgroundColor = #colorLiteral(red: 0.8036853601, green: 0.2847245294, blue: 0.4008832808, alpha: 1)
                self.registerButton.setTitleColor(.white, for: .normal)
            } else {
                self.registerButton.backgroundColor = .lightGray
                self.registerButton.setTitleColor(.gray, for: .normal)
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
        self.view.transform = CGAffineTransform(translationX: 0, y: -difference - 8)
    }
    
    lazy var stackView = VerticalStackView(arrangedSubviews: [
        selectPhotoButton,
        nameTextField,
        emailTextField,
        passwordTextField,
        registerButton
        ], spacing: 8)
    
    private func setupLayout() {
        view.addSubview(stackView)
        stackView.anchor(top: nil, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: 0, left: 50, bottom: 0, right: 50))
        stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        view.addSubview(goToLoginButton)
        goToLoginButton.anchor(top: nil, leading: view.leadingAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, trailing: view.trailingAnchor)
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
