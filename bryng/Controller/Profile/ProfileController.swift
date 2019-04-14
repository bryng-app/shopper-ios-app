//
//  ProfileController.swift
//  bryng
//
//  Created by Florian Woelki on 24.03.19.
//  Copyright © 2019 bryng. All rights reserved.
//

import UIKit
import CoreData
import MessageUI

class ProfileController: BaseViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate, MFMailComposeViewControllerDelegate, MFMessageComposeViewControllerDelegate {

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
        
        fetchProfileImage()
        
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
        let photoHeight = collectionView.bounds.height * 0.2
        profileImageView.layer.cornerRadius = photoHeight / 2
        profileImageView.clipsToBounds = true
        profileImageView.layer.borderColor = #colorLiteral(red: 0.9706280828, green: 0.3376097977, blue: 0.3618901968, alpha: 1)
        profileImageView.layer.borderWidth = 2
    }
    
    @objc private func didTapInviteFriends() {
        let actionMessage = "Hey Du!\nIch benutze die neue App bryng, mit der Du Geld verdienen kannst oder Dir einfach und schnell den Einkauf bringen lassen kannst! Echt geile Sache 💪 (https://bryng.app/)"
        let actions = [
            UIAlertAction(title: "WhatsApp", style: .default, handler: { (action) in
                let encodedActionMessage = actionMessage.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
                if let url = URL(string: "whatsapp://send?text=\(encodedActionMessage!)") {
                    UIApplication.shared.open(url, options: [:], completionHandler: nil)
                } else {
                    AlertUtil.showBasicAlert(viewController: self, title: "Etwas ist schief gegangen!", message: "Höchstwahrscheinlich besitzt Du nicht WhatsApp auf Deinem Smartphone")
                }
            }),
            UIAlertAction(title: "Nachricht", style: .default, handler: { [weak self] (action) in
                if MFMessageComposeViewController.canSendText() {
                    let controller = MFMessageComposeViewController()
                    controller.body = actionMessage
                    controller.messageComposeDelegate = self
                    self?.present(controller, animated: true, completion: nil)
                } else {
                    AlertUtil.showBasicAlert(viewController: self, title: "Etwas ist schief gegangen!", message: "Höchstwahrscheinlich besitzt Du keine Messages App auf Deinem Smartphone")
                }
            }),
            UIAlertAction(title: "E-Mail", style: .default, handler: { [weak self] (action) in
                if MFMailComposeViewController.canSendMail() {
                    let mailComposerVC = MFMailComposeViewController()
                    mailComposerVC.mailComposeDelegate = self
                    mailComposerVC.setSubject("Benutze jetzt auch bryng!")
                    mailComposerVC.setMessageBody("Hey Du!\nIch benutze die neue App bryng, mit der Du Geld verdienen kannst oder Dir einfach und schnell den Einkauf bringen lassen kannst! Echt geile Sache 💪 (https://bryng.app/)", isHTML: false)
                    self?.present(mailComposerVC, animated: true, completion: nil)
                } else {
                    AlertUtil.showBasicAlert(viewController: self, title: "Etwas ist schief gegangen!", message: "Höchstwahrscheinlich besitzt Du keine Mail App auf Deinem Smartphone")
                }
            })
        ]
        AlertUtil.showBasicActionSheet(viewController: self, title: "Lade Deine Freunde ein!", message: "Lade jetzt Deine Freunde ein, damit wir noch mehr Leute erreichen!", actions: actions)
    }
    
    func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
        controller.dismiss(animated: true, completion: nil)
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true, completion: nil)
    }
    
    @objc private func didTapMyProfile() {
        present(MyProfileController(), animated: true, completion: nil)
    }
    
    @objc private func didTapMyOrders() {
        present(OrdersController(), animated: true, completion: nil)
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
        
        setupCircularImageStyle()
        
        dismiss(animated: true) {
            // TODO: Store image in database
            self.handleImageSave()
        }
    }
    
    private func handleImageSave() {
        let context = CoreDataManager.shared.persistentContainer.viewContext
        
        let profile = NSEntityDescription.insertNewObject(forEntityName: "Profile", into: context)
        
        if let profileImage = profileImageView.image {
            let imageData = profileImage.jpegData(compressionQuality: 0.8)
            profile.setValue(imageData, forKey: "imageData")
            
            do {
                try context.save()
            } catch let saveErr {
                print("Something went wrong while saving: \(saveErr)")
            }
        }
    }
    
}