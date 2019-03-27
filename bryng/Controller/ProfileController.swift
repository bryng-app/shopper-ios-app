//
//  ProfileController.swift
//  bryng
//
//  Created by Florian Woelki on 24.03.19.
//  Copyright © 2019 bryng. All rights reserved.
//

import UIKit

class ProfileController: UICollectionViewController {
    
    let photoButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Foto auswählen", for: .normal)
        if (UIDevice.current.screenType == .iPhones_5_5s_5c_SE) {
            button.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .heavy)
        } else {
            button.titleLabel?.font = UIFont.systemFont(ofSize: 24, weight: .heavy)
        }
        button.backgroundColor = #colorLiteral(red: 0.9706280828, green: 0.3376097977, blue: 0.3618901968, alpha: 1)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 16
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
        let photoHeight = collectionView.bounds.height * 0.25
        photoButton.heightAnchor.constraint(equalToConstant: photoHeight).isActive = true
        
        let stackViewSpacing: CGFloat = UIDevice.current.screenType == .iPhones_5_5s_5c_SE ? 12 : 24
        
        let stackView = UIStackView(arrangedSubviews: [
            photoButton,
            UISeperator.create(),
            UIStackView(arrangedSubviews: [
                ordersButton,
                profileButton,
                paymentMethodsButton,
                inviteFriendsButton,
                ], spacing: 6),
            UISeperator.create(),
            UIStackView(arrangedSubviews: [
                socialMediaButton,
                aboutUsButton,
                ], spacing: 6),
            logoutButton
            ], spacing: stackViewSpacing)
        view.addSubview(stackView)
        stackView.anchor(top: nil, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: 0, left: 64, bottom: 0, right: 64))
        stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
    
    init() {
        super.init(collectionViewLayout: UICollectionViewFlowLayout())
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
