//
//  ProfileBaseViewController.swift
//  bryng
//
//  Created by Florian Woelki on 13.04.19.
//  Copyright © 2019 bryng. All rights reserved.
//

import UIKit

class ProfileBaseViewController: BaseViewController, UICollectionViewDelegateFlowLayout {
    
    var headerTitle = "Profile Title"
    var headerBackgroundColor = UIColor.white
    
    var headerView: CloseHeaderView!
    fileprivate let headerId = "headerId"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.backgroundColor = .white
        
        collectionView.register(CloseHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerId)
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerId, for: indexPath) as? CloseHeaderView
        headerView.titleLabel.text = headerTitle
        headerView.backgroundColor = headerBackgroundColor
        headerView.handleDismiss = { [weak self] in
            self?.dismiss(animated: true, completion: nil)
        }
        setupLayout()
        return headerView
    }
    
    func setupLayout() {
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return .init(width: view.frame.width, height: 100)
    }
    
}
