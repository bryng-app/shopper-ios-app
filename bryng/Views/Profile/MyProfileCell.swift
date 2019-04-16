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
    
    lazy var nameTextField: BryngTextField = {
        let tf = BryngTextField(padding: 16, height: 50)
        tf.placeholder = "Dein Name"
        tf.backgroundColor = UIColor.textFieldColor
        tf.clearButtonMode = .whileEditing
        tf.autocorrectionType = .no
        tf.addTarget(self, action: #selector(handleTextChange), for: .editingChanged)
        return tf
    }()
    
    lazy var emailTextField: BryngTextField = {
        let tf = BryngTextField(padding: 16, height: 50, type: .emailAddress)
        tf.placeholder = "Deine E-Mail"
        tf.backgroundColor = UIColor.textFieldColor
        tf.clearButtonMode = .whileEditing
        tf.autocorrectionType = .no
        tf.addTarget(self, action: #selector(handleTextChange), for: .editingChanged)
        return tf
    }()
    
    lazy var phoneTextField: BryngTextField = {
        let tf = BryngTextField(padding: 16, height: 50, type: .phonePad)
        tf.placeholder = "Deine Telefonnummer"
        tf.backgroundColor = UIColor.textFieldColor
        tf.clearButtonMode = .whileEditing
        tf.autocorrectionType = .no
        tf.addTarget(self, action: #selector(handleTextChange), for: .editingChanged)
        return tf
    }()
    
    @objc private func handleTextChange(textField: UITextField) {
        if textField == nameTextField {
            myProfileViewModel.name = textField.text
        } else if textField == emailTextField {
            myProfileViewModel.email = textField.text
        } else {
            myProfileViewModel.phoneNumber = textField.text
        }
    }
    
    var myProfileViewModel = MyProfileViewModel()
    
    lazy var saveButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("Speichern", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.backgroundColor = UIColor.primaryColor
        btn.titleLabel?.font = .boldSystemFont(ofSize: 14)
        btn.heightAnchor.constraint(equalToConstant: 50).isActive = true
        btn.layer.cornerRadius = 25
        btn.addTarget(self, action: #selector(didTapSave), for: .touchUpInside)
        return btn
    }()
    
    let feedbackLabel: UILabel = {
        let label = UILabel(text: "Bitte fülle alle Textfelder aus!")
        label.textColor = UIColor.primaryColor
        label.textAlignment = .center
        label.isHidden = true
        return label
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
            phoneTextField,
            saveButton,
            feedbackLabel
            ], spacing: 16)
        
        addSubview(stackView)
        stackView.anchor(top: nil, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 0, left: 32, bottom: 0, right: 32))
        stackView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    }
    
    @objc private func didTapSave() {
        didClickOnSave?()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    
}
