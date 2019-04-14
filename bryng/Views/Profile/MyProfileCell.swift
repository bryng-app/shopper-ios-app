//
//  MyProfileCell.swift
//  bryng
//
//  Created by Florian Woelki on 14.04.19.
//  Copyright © 2019 bryng. All rights reserved.
//

import UIKit

class MyProfileCell: UICollectionViewCell {
    
    var didClickOnSave: (() -> ())?
    
    let nameTextField: BryngTextField = {
        let tf = BryngTextField(padding: 16, height: 50)
        tf.placeholder = "Dein Name"
        tf.backgroundColor = #colorLiteral(red: 0.9415884067, green: 0.9415884067, blue: 0.9415884067, alpha: 1)
        tf.clearButtonMode = .whileEditing
        tf.autocorrectionType = .no
        return tf
    }()
    
    let emailTextField: BryngTextField = {
        let tf = BryngTextField(padding: 16, height: 50, type: .emailAddress)
        tf.placeholder = "Deine E-Mail"
        tf.backgroundColor = #colorLiteral(red: 0.9415884067, green: 0.9415884067, blue: 0.9415884067, alpha: 1)
        tf.clearButtonMode = .whileEditing
        tf.autocorrectionType = .no
        return tf
    }()
    
    let usernameTextField: BryngTextField = {
        let tf = BryngTextField(padding: 16, height: 50)
        tf.placeholder = "Dein Nutzername"
        tf.backgroundColor = #colorLiteral(red: 0.9415884067, green: 0.9415884067, blue: 0.9415884067, alpha: 1)
        tf.clearButtonMode = .whileEditing
        tf.autocorrectionType = .no
        return tf
    }()
    
    let phoneTextField: BryngTextField = {
        let tf = BryngTextField(padding: 16, height: 50, type: .phonePad)
        tf.placeholder = "Deine Telefonnummer"
        tf.backgroundColor = #colorLiteral(red: 0.9415884067, green: 0.9415884067, blue: 0.9415884067, alpha: 1)
        tf.clearButtonMode = .whileEditing
        tf.autocorrectionType = .no
        return tf
    }()
    
    lazy var saveButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("Speichern", for: .normal)
        btn.setTitleColor(.blue, for: .normal)
        btn.titleLabel?.font = .boldSystemFont(ofSize: 14)
        btn.backgroundColor = #colorLiteral(red: 0.9415884067, green: 0.9415884067, blue: 0.9415884067, alpha: 1)
        btn.heightAnchor.constraint(equalToConstant: 50).isActive = true
        btn.layer.cornerRadius = 16
        btn.addTarget(self, action: #selector(didTapSave), for: .touchUpInside)
        return btn
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .white
        layer.cornerRadius = 16
        
        setupLayout()
    }
    
    private func setupLayout() {
        let stackView = VerticalStackView(arrangedSubviews: [
            nameTextField,
            emailTextField,
            usernameTextField,
            phoneTextField,
            saveButton
            ], spacing: 16)
        
        addSubview(stackView)
        stackView.fillSuperview(padding: .init(top: 32, left: 32, bottom: 32, right: 32))
    }
    
    @objc private func didTapSave() {
        didClickOnSave?()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    
}
