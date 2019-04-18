//
//  ProfileController.swift
//  bryng
//
//  Created by Florian Woelki on 24.03.19.
//  Copyright © 2019 bryng. All rights reserved.
//

import UIKit
import CoreData

class ProfileController: BaseViewController, UICollectionViewDelegateFlowLayout {
    
    fileprivate let cellId = "cellId"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.backgroundColor = .white
        
        collectionView.register(ProfileCell.self, forCellWithReuseIdentifier: cellId)
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! ProfileCell
        
        cell.handleLogout = { [weak self] in
            CoreDataManager.shared.updateLoginSession(isLoggedIn: false)
            
            let navController = UINavigationController(rootViewController: RegistrationController())
            navController.isNavigationBarHidden = true
            self?.present(navController, animated: true)
        }
        
        cell.handleInviteFriends = { [unowned self] in
            let inviteMessage = "Hey Du!\nIch benutze die neue App bryng, mit der Du Geld verdienen kannst oder Dir einfach und schnell den Einkauf bringen lassen kannst! Echt geile Sache 💪 (https://bryng.app/)"
            
            let vc = UIActivityViewController(activityItems: [inviteMessage], applicationActivities: [])
            self.present(vc, animated: true)
        }
        
        cell.handleControllerTap = { [weak self] (viewController) in
            self?.present(viewController, animated: true, completion: nil)
        }
        
        cell.handleImageDismiss = { [weak self] (save) in
            self?.dismiss(animated: true) {
                if save {
                    // TODO: Store image in database
                    self?.handleImageSave(cell: cell)
                }
            }
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: view.frame.width, height: view.frame.height - 100)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    private func handleImageSave(cell: ProfileCell) {
        let context = CoreDataManager.shared.persistentContainer.viewContext
        
        let profile = NSEntityDescription.insertNewObject(forEntityName: "Profile", into: context)
        
        if let profileImage = cell.profileImageView.image {
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
