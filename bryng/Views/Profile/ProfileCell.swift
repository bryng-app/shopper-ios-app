//
//  ProfileCell.swift
//  bryng
//
//  Created by Florian Woelki on 18.04.19.
//  Copyright © 2019 bryng. All rights reserved.
//

import UIKit
import CoreData
import MessageUI

class ProfileCell: UICollectionViewCell, UINavigationControllerDelegate, UIImagePickerControllerDelegate, MFMailComposeViewControllerDelegate, MFMessageComposeViewControllerDelegate {
    
    var handleLogout: (() -> ())?
    var handleInviteFriends: (() -> ())?
    var handleControllerTap: ((UIViewController) -> ())?
    var handleImageDismiss: ((Bool) -> ())?
    var handleSelectPhotoPresent: (() -> ())?
    
    let imageHeight: CGFloat = 150
    
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
    
    lazy var logoutButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Ausloggen", for: .normal)
        button.setTitleColor(UIColor.primaryColor, for: .normal)
        button.layer.cornerRadius = 24
        button.addTarget(self, action: #selector(didTapOnLogout), for: .touchUpInside)
        return button
    }()
    
    @objc private func didTapOnLogout() {
        handleLogout?()
    }
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        backgroundColor = .white
        
        setupLayout()
    }
    
    fileprivate func setupLayout() {
        let stackViewSpacing: CGFloat = UIDevice.current.screenType == .iPhones_5_5s_5c_SE ? 12 : 24
        
        fetchProfileImage()
        
        addSubview(profileImageView)
        profileImageView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        profileImageView.widthAnchor.constraint(equalToConstant: imageHeight).isActive = true
        profileImageView.heightAnchor.constraint(equalToConstant: imageHeight).isActive = true
        profileImageView.anchor(top: topAnchor, leading: nil, bottom: nil, trailing: nil, padding: .init(top: imageHeight / 2, left: 0, bottom: 0, right: 0))
        
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
        addSubview(stackView)
        stackView.anchor(top: profileImageView.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 32, left: 64, bottom: 0, right: 64))
        
        aboutUsButton.addTarget(self, action: #selector(didTapAboutUs), for: .touchUpInside)
        socialMediaButton.addTarget(self, action: #selector(didTapSocialMedia), for: .touchUpInside)
        ordersButton.addTarget(self, action: #selector(didTapMyOrders), for: .touchUpInside)
        profileButton.addTarget(self, action: #selector(didTapMyProfile), for: .touchUpInside)
        inviteFriendsButton.addTarget(self, action: #selector(didTapInviteFriends), for: .touchUpInside)
    }
    
    private func fetchProfileImage() {
        let context = CoreDataManager.shared.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Profile")
        do {
            let result = try context.fetch(request)
            for data in result as! [NSManagedObject] {
                if let imageData = data.value(forKey: "imageData") {
                    profileImageView.image = UIImage(data: imageData as! Data)
                    setupCircularImageStyle()
                }
            }
        } catch {
            print("Failed to fetch profile data")
        }
    }
    
    private func setupCircularImageStyle() {
        profileImageView.layer.cornerRadius = imageHeight / 2
        profileImageView.clipsToBounds = true
        profileImageView.layer.borderColor = UIColor.primaryColor.cgColor
        profileImageView.layer.borderWidth = 2
    }
    
    @objc private func didTapInviteFriends() {
        handleInviteFriends?()
    }
    
    func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
        controller.dismiss(animated: true, completion: nil)
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true, completion: nil)
    }
    
    @objc private func didTapMyProfile() {
        handleControllerTap?(MyProfileController())
    }
    
    @objc private func didTapMyOrders() {
        handleControllerTap?(OrdersController())
    }
    
    @objc private func didTapAboutUs() {
        handleControllerTap?(AboutUsController())
    }
    
    @objc private func didTapSocialMedia() {
        handleControllerTap?(SocialMediaController())
    }
    
    @objc private func handleSelectPhoto() {
        let imagePickerController = UIImagePickerController()
        
        imagePickerController.delegate = self
        imagePickerController.allowsEditing = true
        
        handleControllerTap?(imagePickerController)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        handleImageDismiss?(false)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let editedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            profileImageView.image = editedImage
        } else if let originalImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            profileImageView.image = originalImage
        }
        
        setupCircularImageStyle()
        
        handleImageDismiss?(true)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
