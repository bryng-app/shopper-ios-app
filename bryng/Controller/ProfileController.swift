//
//  ProfileController.swift
//  bryng
//
//  Created by Florian Woelki on 24.03.19.
//  Copyright © 2019 bryng. All rights reserved.
//

import UIKit

class ProfileController: BaseViewController {
    
    let photoButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Foto\nauswählen", for: .normal)
        button.titleLabel?.numberOfLines = 0
        button.titleLabel?.textAlignment = .center
        if (UIDevice.current.screenType == .iPhones_5_5s_5c_SE) {
            button.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        } else {
            button.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        }
        button.backgroundColor = #colorLiteral(red: 0.9706280828, green: 0.3376097977, blue: 0.3618901968, alpha: 1)
        button.setTitleColor(.white, for: .normal)
        return button
    }()
    
    let ordersButton = ButtonWithImage(title: "Meine Bestellungen", imageName: "purchase-order")
    let profileButton = ButtonWithImage(title: "Mein Profil", imageName: "contacts")
    let paymentMethodsButton = ButtonWithImage(title: "Meine Zahlungsarten", imageName: "expensive-price")
    let inviteFriendsButton = ButtonWithImage(title: "Freunde einladen", imageName: "invite")
    
    let socialMediaButton = ButtonWithImage(title: "Social Media", imageName: "share")
    let aboutUsButton = ButtonWithImage(title: "Über uns", imageName: "about")
    
    let logoutButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Ausloggen", for: .normal)
        button.setTitleColor(#colorLiteral(red: 0.9706280828, green: 0.3376097977, blue: 0.3618901968, alpha: 1), for: .normal)
        button.layer.cornerRadius = 24
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.backgroundColor = .white
        
        setupLayout()
    }
    
    fileprivate func setupLayout() {
        let stackViewSpacing: CGFloat = UIDevice.current.screenType == .iPhones_5_5s_5c_SE ? 12 : 24
        
        view.addSubview(photoButton)
        let photoHeight = collectionView.bounds.height * 0.2
        photoButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        photoButton.widthAnchor.constraint(equalToConstant: photoHeight).isActive = true
        photoButton.heightAnchor.constraint(equalToConstant: photoHeight).isActive = true
        photoButton.anchor(top: view.topAnchor, leading: nil, bottom: nil, trailing: nil, padding: .init(top: photoHeight / 2, left: 0, bottom: 0, right: 0))
        photoButton.layer.cornerRadius = photoHeight / 2
        
        let stackView = VerticalStackView(arrangedSubviews: [
            UISeperator.create(),
            VerticalStackView(arrangedSubviews: [
                ordersButton,
                profileButton,
                paymentMethodsButton,
                inviteFriendsButton,
                ], spacing: 6),
            UISeperator.create(),
            VerticalStackView(arrangedSubviews: [
                socialMediaButton,
                aboutUsButton,
                ], spacing: 6),
            logoutButton
            ], spacing: stackViewSpacing)
        view.addSubview(stackView)
        stackView.anchor(top: photoButton.bottomAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: 32, left: 64, bottom: 0, right: 64))
    }
    
}
