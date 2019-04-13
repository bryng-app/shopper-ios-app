//
//  AboutUsController.swift
//  bryng
//
//  Created by Florian Woelki on 13.04.19.
//  Copyright © 2019 bryng. All rights reserved.
//

import UIKit

class AboutUsController: BaseViewController, UICollectionViewDelegateFlowLayout {
    
    fileprivate let headerId = "headerId"
    fileprivate var closeHeaderView: CloseHeaderView!
    
    fileprivate let blogButton = ButtonWithLink(title: "Blog")
    fileprivate let placesButton = ButtonWithLink(title: "Standorte")
    
    fileprivate let impressumButton = ButtonWithLink(title: "Impressum")
    fileprivate let datenschutzButton = ButtonWithLink(title: "Datenschutz")
    fileprivate let agbButton = ButtonWithLink(title: "AGB")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.backgroundColor = .white
        
        collectionView.register(CloseHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerId)
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        closeHeaderView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerId, for: indexPath) as? CloseHeaderView
        closeHeaderView.titleLabel.text = "Über Uns"
        closeHeaderView.handleDismiss = { [weak self] in
            self?.dismiss(animated: true, completion: nil)
        }
        
        setupLayout()
        
        return closeHeaderView
    }
    
    fileprivate func setupLayout() {
        blogButton.link = "https://bryng.app/blog/"
        placesButton.link = "https://bryng.app/places/"
        impressumButton.link = "https://bryng.app/impressum/"
        datenschutzButton.link = "https://bryng.app/datenschutz/"
        agbButton.link = "https://bryng.app/agb/"
        
        let stackView = VerticalStackView(arrangedSubviews: [
            blogButton,
            placesButton,
            UISeperator.create(),
            impressumButton,
            datenschutzButton,
            agbButton
            ], spacing: 16)
        
        collectionView.addSubview(stackView)
        stackView.anchor(top: closeHeaderView.bottomAnchor, leading: collectionView.leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: 8, left: 24, bottom: 0, right: 0))
        
        [blogButton, placesButton, impressumButton, datenschutzButton, agbButton].forEach({$0.addTarget(self, action: #selector(didTapLinkButton(sender:)), for: .touchUpInside)})
    }
    
    @objc fileprivate func didTapLinkButton(sender: ButtonWithLink) {
        if let url = URL(string: sender.link) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        
        return .init(width: view.frame.width, height: 100)
    }
    
}
