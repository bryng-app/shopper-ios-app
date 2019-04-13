//
//  ProfileController.swift
//  bryng
//
//  Created by Florian Woelki on 24.03.19.
//  Copyright © 2019 bryng. All rights reserved.
//

import UIKit

class ProfileController: BaseViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {

    lazy var profileImageView: UIImageView = {
        let imageView = UIImageView(image: #imageLiteral(resourceName: "select_photo_empty"))
        imageView.isUserInteractionEnabled = true
        imageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleSelectPhoto)))
        return imageView
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
        
        view.addSubview(profileImageView)
        let photoHeight = collectionView.bounds.height * 0.2
        profileImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        profileImageView.widthAnchor.constraint(equalToConstant: photoHeight).isActive = true
        profileImageView.heightAnchor.constraint(equalToConstant: photoHeight).isActive = true
        profileImageView.anchor(top: view.topAnchor, leading: nil, bottom: nil, trailing: nil, padding: .init(top: photoHeight / 2, left: 0, bottom: 0, right: 0))

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
        stackView.anchor(top: profileImageView.bottomAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: 32, left: 64, bottom: 0, right: 64))
        
        aboutUsButton.addTarget(self, action: #selector(didTapAboutUs), for: .touchUpInside)
        socialMediaButton.addTarget(self, action: #selector(didTapSocialMedia), for: .touchUpInside)
    }
    
    @objc private func didTapAboutUs() {
        present(AboutUsController(), animated: true, completion: nil)
    }
    
    @objc private func didTapSocialMedia() {
        present(SocialMediaController(), animated: true, completion: nil)
    }
    
    @objc private func handleSelectPhoto() {
        let imagePickerController = UIImagePickerController()
        
        imagePickerController.delegate = self
        imagePickerController.allowsEditing = true
        
        present(imagePickerController, animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let editedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            profileImageView.image = editedImage
        } else if let originalImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            profileImageView.image = originalImage
        }
        
        profileImageView.layer.cornerRadius = profileImageView.frame.width / 2
        profileImageView.clipsToBounds = true
        profileImageView.layer.borderColor = #colorLiteral(red: 0.9706280828, green: 0.3376097977, blue: 0.3618901968, alpha: 1)
        profileImageView.layer.borderWidth = 2
        
        dismiss(animated: true, completion: nil)
    }
    
}
