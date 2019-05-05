//
//  CategoriesController.swift
//  bryng
//
//  Created by Florian Woelki on 05.05.19.
//  Copyright © 2019 bryng. All rights reserved.
//

import UIKit

class CategoriesListController: HorizontalSnappingController, UICollectionViewDelegateFlowLayout {
    
    var categories: [StoreCategory]? {
        didSet {
            collectionView.reloadData()
        }
    }
    
    private let cellId = "cellId"
    private var selectedIndex = Int()
    
    var didSelectCategory: ((_ category: StoreCategory, _ index: IndexPath) ->())?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.backgroundColor = #colorLiteral(red: 0.08624383062, green: 0.08629330248, blue: 0.07807467133, alpha: 1)
        
        collectionView.register(CategoryListCell.self, forCellWithReuseIdentifier: cellId)
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! CategoryListCell
        
        if let categories = categories {
            cell.categoryLabel.text = categories[indexPath.row].name
            cell.isCategorySelected = selectedIndex == indexPath.row
        }
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let categories = categories else { return 0 }
        
        return categories.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let categories = categories else { return }
        
        selectedIndex = indexPath.row
        didSelectCategory?(categories[indexPath.row], indexPath)
        
        collectionView.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: 150, height: view.frame.height)
    }
    
}
