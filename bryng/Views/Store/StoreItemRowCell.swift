//
//  StoreItemRowCell.swift
//  bryng
//
//  Created by Florian Woelki on 09.04.19.
//  Copyright © 2019 bryng. All rights reserved.
//

import UIKit

class StoreItemRowCell: UICollectionViewCell {
    
    let imageView: UIImageView = {
        let iv = UIImageView()
        iv.backgroundColor = .yellow
        iv.constrainWidth(constant: 64)
        iv.constrainHeight(constant: 64)
        return iv
    }()
    
    let nameLabel = UILabel(text: "Item Name", font: .systemFont(ofSize: 20))
    
    let getButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("Einkaufen", for: .normal)
        return btn
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        getButton.backgroundColor = UIColor(white: 0.95, alpha: 1)
        getButton.constrainWidth(constant: 80)
        getButton.constrainHeight(constant: 32)
        getButton.titleLabel?.font = .boldSystemFont(ofSize: 16)
        getButton.layer.cornerRadius = 32 / 2
        
        let stackView = UIStackView(arrangedSubviews: [
            imageView, nameLabel, getButton
            ])
        stackView.spacing = 16
        stackView.alignment = .center
        
        addSubview(stackView)
        stackView.fillSuperview()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    
}
