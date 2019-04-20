//
//  MyProfileController.swift
//  bryng
//
//  Created by Florian Woelki on 14.04.19.
//  Copyright © 2019 bryng. All rights reserved.
//

import UIKit
import JGProgressHUD

class MyProfileController: ProfileBaseViewController {
    
    private let cellId = "cellId"
    
    private var isFormValid = false
    private var myProfileViewModel: MyProfileViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        headerBackgroundColor = .modernGray
        headerTitle = "Profil"
        collectionView.backgroundColor = .modernGray
        
        collectionView.register(MyProfileCell.self, forCellWithReuseIdentifier: cellId)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        collectionView.addGestureRecognizer(tap)
    }
    
    @objc private func dismissKeyboard() {
        collectionView.endEditing(true)
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! MyProfileCell
        
        GraphQL.shared.getAuthorizedApollo(token: nil) { (apollo) in
            let meQuery = MeQuery()
            
            apollo.fetch(query: meQuery) { result, error in
                if let error = error {
                    print("Something went wrong with me query. \(error)")
                    return
                }
                
                guard let me = result?.data?.me else { return }
                
                cell.profileModel = ProfileModel(fullname: me.fullname, email: me.email, phoneNumber: nil)
            }
        }
        
        myProfileViewModel = cell.myProfileViewModel
        setupMyProfileViewModelObserver()
        
        cell.didClickOnSave = {
            if self.isFormValid {
                let progressHUD = JGProgressHUD(style: .dark)
                progressHUD.textLabel.text = "Speichere Daten"
                progressHUD.dismiss(afterDelay: 0.5, animated: true)
                progressHUD.show(in: self.view)
                DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
                    self.dismiss(animated: true, completion: nil)
                })
            } else {
                AlertUtil.showProgressAlert(view: self.view, text: "Bitte fülle alle Textfelder aus!")
            }
        }
        
        return cell
    }
    
    private func setupMyProfileViewModelObserver() {
        myProfileViewModel.isFormValidObserver = { [unowned self] (isFormValid) in
            self.isFormValid = isFormValid
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 24
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .init(top: 24, left: 0, bottom: 24, right: 0)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: view.frame.width - 32, height: 350)
    }
    
}
