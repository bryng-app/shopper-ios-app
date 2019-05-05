//
//  CategoriesListCell.swift
//  bryng
//
//  Created by Florian Woelki on 05.05.19.
//  Copyright © 2019 bryng. All rights reserved.
//

import UIKit

class CategoriesListCell: UICollectionViewCell {
    
    var categories: [StoreCategory]? {
        didSet {
            guard let categories = categories else { return }
            
            categoriesListController.categories = categories
        }
    }
    var didSelectCategory: ((_ category: StoreCategory, _ index: IndexPath) -> ())?
    
    private let categoriesListController = CategoriesListController()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(categoriesListController.view)
        categoriesListController.view.fillSuperview()
        
        categoriesListController.didSelectCategory = { category, index in
            self.didSelectCategory?(category, index)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    
}
