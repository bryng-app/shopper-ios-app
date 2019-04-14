//
//  MyProfileCell.swift
//  bryng
//
//  Created by Florian Woelki on 14.04.19.
//  Copyright © 2019 bryng. All rights reserved.
//

import UIKit

class MyProfileTextField: UITextField {
    
    convenience init(placeholder: String, type: UIKeyboardType = .default) {
        self.init(frame: .zero)
        self.placeholder = placeholder
        backgroundColor = #colorLiteral(red: 0.9808533031, green: 0.9808533031, blue: 0.9808533031, alpha: 1)
        borderStyle = .roundedRect
        autocorrectionType = .no
        keyboardType = type
        returnKeyType = .done
        clearButtonMode = .whileEditing
        contentVerticalAlignment = .center
    }
    
}

class MyProfileCell: UICollectionViewCell {
    
    var didClickOnSave: (() -> ())?
    
    let nameLabel = UILabel(text: "Name")
    let nameTextField = MyProfileTextField(placeholder: "Name ...")
    
    let emailLabel = UILabel(text: "E-Mail")
    let emailTextField = MyProfileTextField(placeholder: "E-Mail ...", type: .emailAddress)
    
    let usernameLabel = UILabel(text: "Nutzername")
    let usernameTextField = MyProfileTextField(placeholder: "Nutzername ...")
    
    let phoneLabel = UILabel(text: "Handy")
    let phoneTextField = MyProfileTextField(placeholder: "Telefonnummer ...", type: .phonePad)
    
    let saveButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("Speichern", for: .normal)
        btn.setTitleColor(.blue, for: .normal)
        btn.titleLabel?.font = .boldSystemFont(ofSize: 14)
        btn.backgroundColor = UIColor(white: 0.95, alpha: 1)
        btn.widthAnchor.constraint(equalToConstant: 95).isActive = true
        btn.heightAnchor.constraint(equalToConstant: 36).isActive = true
        btn.layer.cornerRadius = 16
        return btn
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .white
        layer.cornerRadius = 16
        
        setupLayout()
    }
    
    private func setupLayout() {
        let nameStackView = UIStackView(arrangedSubviews: [
            nameLabel,
            nameTextField
            ])
        let emailStackView = UIStackView(arrangedSubviews: [
            emailLabel,
            emailTextField
            ])
        let usernameStackView = UIStackView(arrangedSubviews: [
            usernameLabel,
            usernameTextField
            ])
        let phoneStackView = UIStackView(arrangedSubviews: [
            phoneLabel,
            phoneTextField
            ])
        
        [nameStackView, emailStackView, usernameStackView, phoneStackView].forEach({$0.spacing = 32})
        
        let height = bounds.width * 0.5
        [nameTextField, emailTextField, usernameTextField, phoneTextField].forEach({$0.constrainWidth(constant: height)})
        
        let stackView = VerticalStackView(arrangedSubviews: [
            nameStackView,
            emailStackView,
            usernameStackView,
            phoneStackView,
            ], spacing: 32)
        
        addSubview(stackView)
        stackView.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: 32, left: 32, bottom: 0, right: 0))
        
        addSubview(saveButton)
        saveButton.anchor(top: nil, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: .init(top: 0, left: 32, bottom: 32, right: 32))
        saveButton.addTarget(self, action: #selector(didTapSave), for: .touchUpInside)
    }
    
    @objc private func didTapSave() {
        didClickOnSave?()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    
}
