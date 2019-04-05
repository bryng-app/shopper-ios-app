//
//  StoreCategoryController.swift
//  bryng
//
//  Created by Florian Woelki on 04.04.19.
//  Copyright © 2019 bryng. All rights reserved.
//

import UIKit

class StoreCategoryController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    fileprivate var storeName: String!
    
    fileprivate let cellId = "cellId"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.backgroundColor = #colorLiteral(red: 0.9415884067, green: 0.9415884067, blue: 0.9415884067, alpha: 1)
        navigationItem.title = storeName
        
        collectionView.register(StoreCategoryCell.self, forCellWithReuseIdentifier: cellId)
        navigationItem.largeTitleDisplayMode = .never
        
        // Set top right shopping cart button
        let cartButton = UIButton(type: .system)
        cartButton.setImage(#imageLiteral(resourceName: "shopping-cart").withRenderingMode(.alwaysOriginal), for: .normal)
        cartButton.frame = CGRect(x: 0, y: 0, width: 38, height: 32)
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: cartButton)
    }
    
    init(storeName: String) {
        self.storeName = storeName
        
        super.init(collectionViewLayout: UICollectionViewFlowLayout())
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 8
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! StoreCategoryCell
        return cell
    }
    
    fileprivate var itemsController: StoreItemsController!
    
    var topConstraint: NSLayoutConstraint?
    var leadingConstraint: NSLayoutConstraint?
    var widthConstraint: NSLayoutConstraint?
    var heightConstraint: NSLayoutConstraint?
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let fullscreenController = StoreItemsController()
        let fullscreenView = fullscreenController.view!
        
        fullscreenView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleRemoveView)))
        view.addSubview(fullscreenView)
        
        addChild(fullscreenController)
        
        self.itemsController = fullscreenController
        
        guard let cell = collectionView.cellForItem(at: indexPath) else { return }
        
        guard let startingFrame = cell.superview?.convert(cell.frame, to: nil) else { return }
        
        self.startingFrame = startingFrame
        fullscreenView.layer.cornerRadius = 16
        
        fullscreenView.translatesAutoresizingMaskIntoConstraints = false
        topConstraint = fullscreenView.topAnchor.constraint(equalTo: view.topAnchor, constant: startingFrame.origin.y)
        leadingConstraint = fullscreenView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: startingFrame.origin.x)
        widthConstraint = fullscreenView.widthAnchor.constraint(equalToConstant: startingFrame.width)
        heightConstraint = fullscreenView.heightAnchor.constraint(equalToConstant: startingFrame.height)
        
        [topConstraint, leadingConstraint, widthConstraint, heightConstraint].forEach({$0?.isActive = true})
        self.view.layoutIfNeeded()
        
        UIView.animate(withDuration: 0.7, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.7, options: .curveEaseOut, animations: {
            
            self.topConstraint?.constant = 0
            self.leadingConstraint?.constant = 0
            self.widthConstraint?.constant = self.view.frame.width
            self.heightConstraint?.constant = self.view.frame.height
            
            self.view.layoutIfNeeded()
            
            self.navigationController?.navigationBar.transform = CGAffineTransform(translationX: 0, y: -100)
            self.tabBarController?.tabBar.transform = CGAffineTransform(translationX: 0, y: 100)
        
        }, completion: nil)
    }
    
    fileprivate var startingFrame: CGRect?
    
    @objc fileprivate func handleRemoveView(gesture: UITapGestureRecognizer) {
        UIView.animate(withDuration: 0.7, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.7, options: .curveEaseOut, animations: {
            
            guard let startingFrame = self.startingFrame else { return }
            
            self.topConstraint?.constant = startingFrame.origin.y
            self.leadingConstraint?.constant = startingFrame.origin.x
            self.widthConstraint?.constant = startingFrame.width
            self.heightConstraint?.constant = startingFrame.height
            
            self.view.layoutIfNeeded()
            
            self.navigationController?.navigationBar.transform = .identity
            self.tabBarController?.tabBar.transform = .identity
        
        }, completion: { _ in
            gesture.view?.removeFromSuperview()
            self.itemsController.removeFromParent()
        })
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: view.frame.width - 64, height: 100)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 32
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .init(top: 32, left: 0, bottom: 32, right: 0)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
