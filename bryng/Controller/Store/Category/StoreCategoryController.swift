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
