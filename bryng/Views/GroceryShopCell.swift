//
//  GroceryShopCell.swift
//  bryng
//
//  Created by Florian Woelki on 03.04.19.
//  Copyright © 2019 bryng. All rights reserved.
//

import UIKit

class GroceryShopCell: UICollectionViewCell {
    
    let imageView: UIImageView = {
        let iv = UIImageView()
        iv.backgroundColor = .red
        iv.widthAnchor.constraint(equalToConstant: 64).isActive = true
        iv.heightAnchor.constraint(equalToConstant: 64).isActive = true
        return iv
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Store Name"
        return label
    }()
    
    let distanceLabel: UILabel = {
        let label = UILabel()
        label.text = "7.4km entfernt"
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()
    
    let goToButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("Einkaufen", for: .normal)
        btn.setTitleColor(.blue, for: .normal)
        btn.titleLabel?.font = .boldSystemFont(ofSize: 14)
        btn.backgroundColor = UIColor(white: 0.95, alpha: 1)
        btn.widthAnchor.constraint(equalToConstant: 95).isActive = true
        btn.heightAnchor.constraint(equalToConstant: 36).isActive = true
        btn.layer.cornerRadius = 16
        return btn
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .green
        
        let labelsStackView = UIStackView(arrangedSubviews: [
            nameLabel, distanceLabel
            ], spacing: 0)
        
        let stackView = UIStackView(arrangedSubviews: [
            imageView, labelsStackView, goToButton
            ], spacing: 12, horizontal: true)
        stackView.alignment = .center
        
        addSubview(stackView)
        stackView.fillSuperview(padding: .init(top: 16, left: 24, bottom: 16, right: 24))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
