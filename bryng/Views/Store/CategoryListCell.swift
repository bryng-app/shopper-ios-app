//
//  CategoryListCell.swift
//  bryng
//
//  Created by Florian Woelki on 05.05.19.
//  Copyright © 2019 bryng. All rights reserved.
//

import UIKit

class CategoryListCell: UICollectionViewCell {
    
    var categoryLabel: UILabel = {
        let label = UILabel()
        label.text = "Category"
        label.font = UIFont.systemFont(ofSize: 16)
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    var isCategorySelected: Bool? {
        didSet {
            guard let isCategorySelected = isCategorySelected else { return }
            
            backgroundColor = isCategorySelected ? .white : .lightGray
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .lightGray
        roundCorners(corners: [.topLeft, .topRight], radius: 8)
        
        addSubview(categoryLabel)
        categoryLabel.anchor(top: topAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    
}
