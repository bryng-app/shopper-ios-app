//
//  StoreItemsGroupCell.swift
//  bryng
//
//  Created by Florian Woelki on 09.04.19.
//  Copyright © 2019 bryng. All rights reserved.
//

import UIKit

class StoreItemsGroupCell: UICollectionViewCell {
    
    var storeCategory: StoreCategory? {
        didSet {
            guard let storeCategory = storeCategory else { return }
            
            titleLabel.text = storeCategory.name
            horizontalController.category = storeCategory.name
        }
    }
    
    fileprivate let titleLabel = UILabel(text: "Section", font: .boldSystemFont(ofSize: 30))
    fileprivate let horizontalController = StoreItemsHorizontalController()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(titleLabel)
        titleLabel.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 24, left: 16, bottom: 0, right: 0))
        
        addSubview(horizontalController.view)
        horizontalController.view.anchor(top: titleLabel.bottomAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    
}
